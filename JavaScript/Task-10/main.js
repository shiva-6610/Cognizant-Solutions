// Event data (use const because reference should not change)
const events = [
  { id: 1, name: "Tech Talk", category: "Education", seats: 5 },
  { id: 2, name: "Music Fest", category: "Entertainment", seats: 0 },
  { id: 3, name: "AI Workshop", category: "Education", seats: 10 }
];

// 1. Default parameter + const/let usage
function registerEvent(eventId, userName = "Guest") {
  const event = events.find(e => e.id === eventId);

  if (!event) {
    console.log("Event not found");
    return;
  }

  if (event.seats <= 0) {
    console.log(`Sorry ${userName}, no seats available for ${event.name}`);
    return;
  }

  event.seats--; // using let/const concept (mutating object property)

  console.log(`${userName} registered for ${event.name}`);
}

// 2. Destructuring example
function showEventDetails(eventObj) {
  const { name, category, seats } = eventObj; // destructuring

  console.log("Event Details:");
  console.log(`Name: ${name}`);
  console.log(`Category: ${category}`);
  console.log(`Seats left: ${seats}`);
}

// 3. Spread operator (clone array before filtering)
function showEducationEvents() {
  const eventsCopy = [...events]; // spread operator (clone array)

  const educationEvents = eventsCopy.filter(
    event => event.category === "Education"
  );

  console.log("Education Events:");
  educationEvents.forEach(e => console.log(e.name));
}

// 4. Run examples
registerEvent(1, "Shivani");
registerEvent(2, "Akhil");

showEventDetails(events[0]);

showEducationEvents();