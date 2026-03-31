import React, { useState } from "react"
import { createRoot } from "react-dom/client"

function StarRating({ initialRating = 0, resourceType, resourceId }) {
  const [rating, setRating] = useState(initialRating)
  const [hover, setHover] = useState(0)

  const handleClick = (value) => {
    setRating(value)

    fetch(`/${resourceType}/${resourceId}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ [resourceType.slice(0, -1)]: { rating: value } })
    })
  }

  return React.createElement("div", { className: "star-rating" },
    [1, 2, 3, 4, 5].map(star =>
      React.createElement("span", {
        key: star,
        className: `star ${star <= (hover || rating) ? "active" : ""}`,
        onClick: () => handleClick(star),
        onMouseEnter: () => setHover(star),
        onMouseLeave: () => setHover(0),
        style: { cursor: "pointer", fontSize: "24px", color: star <= (hover || rating) ? "#f5a623" : "#ccc" }
      }, "★")
    )
  )
}

export function mountStarRating() {
  document.querySelectorAll("[data-star-rating]").forEach(el => {
    const root = createRoot(el)
    root.render(
      React.createElement(StarRating, {
        initialRating: parseInt(el.dataset.initialRating) || 0,
        resourceType: el.dataset.resourceType,
        resourceId: el.dataset.resourceId
      })
    )
  })
}
