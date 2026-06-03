// Sample event data
let events = [
  { id: 1, name: "Tech Talk", seats: 2 },
  { id: 2, name: "Music Fest", seats: 1 },
  { id: 3, name: "Workshop on Baking", seats: 3 }
];

// Access DOM using querySelector
const eventList = document.querySelector("#eventList");

// Function to render events
function displayEvents() {
  eventList.innerHTML = ""; // clear old list

  events.forEach(event => {
    const li = document.createElement("li");

    li.innerHTML = `
      <strong>${event.name}</strong> 
      - Seats: ${event.seats}
      <button onclick="register(${event.id})">Register</button>
      <button onclick="cancel(${event.id})">Cancel</button>
    `;

    eventList.appendChild(li);
  });
}

// Register function
function register(id) {
  const event = events.find(e => e.id === id);

  if (event.seats > 0) {
    event.seats--;
  } else {
    alert("No seats available!");
  }

  displayEvents(); // update UI
}

// Cancel function
function cancel(id) {
  const event = events.find(e => e.id === id);

  event.seats++; // increase seats back

  displayEvents(); // update UI
}

// Initial render
displayEvents();