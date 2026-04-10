import { Controller } from "@hotwired/stimulus"
import { Chart, DoughnutController, ArcElement, Tooltip, Legend } from "chart.js"

// Регистрируем только нужные компоненты Chart.js (меньше размер)
Chart.register(DoughnutController, ArcElement, Tooltip, Legend)

export default class extends Controller {
  static values = { stats: Object }

  connect() {
    this.renderChart("movies-chart", this.statsValue.movies)
    this.renderChart("books-chart",  this.statsValue.books)
    this.renderChart("recipes-chart", this.statsValue.recipes)
  }

  renderChart(canvasId, data) {
    const canvas = document.getElementById(canvasId)
    if (!canvas) return

    const total = data.completed + data.watching + data.want
    if (total === 0) {
      canvas.parentElement.innerHTML += `<p class="chart-empty">Nothing added yet</p>`
      canvas.style.display = "none"
      return
    }

    new Chart(canvas, {
      type: "doughnut",
      data: {
        labels: ["Completed", "In progress", "Want"],
        datasets: [{
          data: [data.completed, data.watching, data.want],
          backgroundColor: ["#ffffff", "#888888", "#333333"],
          borderColor: ["#0f0f0f", "#0f0f0f", "#0f0f0f"],
          borderWidth: 3
        }]
      },
      options: {
        responsive: true,
        plugins: {
          legend: {
            position: "bottom",
            labels: {
              color: "#aaaaaa",
              font: { family: "serif", size: 12 },
              padding: 16
            }
          },
          tooltip: {
            callbacks: {
              label: (ctx) => ` ${ctx.label}: ${ctx.raw}`
            }
          }
        }
      }
    })
  }
}
