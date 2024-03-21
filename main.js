import "normalize.css";
import "./style.css";
import { main } from "./src/power_pack.gleam";

document.addEventListener("DOMContentLoaded", () => {
  const dispatch = main({});
});
