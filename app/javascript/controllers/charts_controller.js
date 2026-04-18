import { Controller } from "@hotwired/stimulus"
import { Chart, DoughnutController, ArcElement, Tooltip, Legend } from "chart.js"

Chart.register(DoughnutController, ArcElement, Tooltip, Legend)

export default class extends Controller {
  static values = { stats: Object }

  connect() {
    this.charts = []
    requestAnimationFrame(() => {
      this.renderChart("movies-chart",  this.statsValue.movies)
      this.renderChart("books-chart",   this.statsValue.books)
      this.renderChart("recipes-chart", this.statsValue.recipes)
    })
  }

  disconnect() {
    this.charts.forEach(c => c.destroy())
    this.charts = []
  }

  renderChart(canvasId, data) {
    const canvas = document.getElementById(canvasId)
    if (!canvas) return

    const total = (data.completed || 0) + (data.watching || 0) + (data.want || 0)
    if (total === 0) {
      canvas.style.display = "none"
      const empty = document.createElement("p")
      empty.className = "chart-empty"
      empty.textContent = "Nothing added yet"
      canvas.parentElement.appendChild(empty)
      return
    }

    const existing = Chart.getChart(canvas)
    if (existing) existing.destroy()

    const chart = new Chart(canvas, {
      type: "doughnut",
      data: {
        labels: ["Completed", "In progress", "Want"],
        datasets: [{
          data: [data.completed || 0, data.watching || 0, data.want || 0],
          backgroundColor: ["#ffffff", "#888888", "#333333"],
          borderColor: ["#0f0f0f", "#0f0f0f", "#0f0f0f"],
          borderWidth: 3
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
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

    this.charts.push(chart)
  }
}
