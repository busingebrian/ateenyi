const path = require("path");
const express = require("express");

const app = express();
const port = process.env.PORT || 3000;

// Serve the static site (html/css/js/images) from repo root.
app.use(express.static(path.join(__dirname)));

// Basic health check
app.get("/healthz", (req, res) => {
  res.status(200).send("ok");
});

// Fallback to homepage
app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "index.html"));
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});