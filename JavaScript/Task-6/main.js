// 1. Initial array of events
let events = [
  { name: "Music Night", category: "Music" },
  { name: "Baking Workshop", category: "Workshop" },
  { name: "Tech Talk", category: "Education" }
];

console.log("Original Events:");
console.log(events);

// 2. Add new events using push()
events.push(
  { name: "DJ Party", category: "Music" },
  { name: "Coding Bootcamp", category: "Education" }
);

console.log("\nAfter Adding New Events:");
console.log(events);

// 3. Filter only Music events
let musicEvents = events.filter(event => event.category === "Music");

console.log("\nMusic Events Only:");
console.log(musicEvents);

// 4. Format all events using map()
let displayCards = events.map(event => {
  return `🎉 ${event.name} (${event.category})`;
});

console.log("\nFormatted Event Cards:");
displayCards.forEach(card => console.log(card));

// 5. BONUS: Music events formatted nicely
let musicCards = events
  .filter(event => event.category === "Music")
  .map(event => `🎵 ${event.name}`);

console.log("\nMusic Event Cards:");
musicCards.forEach(card => console.log(card));