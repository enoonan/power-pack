import gleam/int
import lustre
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event
import lustre/ui
import lustre/ui/styles

// MAIN ------------------------------------------------------------------------

pub fn main() {
  let app = lustre.simple(init, update, view)
  let assert Ok(_) = lustre.start(app, "[data-lustre-app]", 10)
}

// MODEL -----------------------------------------------------------------------

pub type Model {
  Model(
    total_sites: Int,
    power_packs: Int,
    power_pack_micros: Int
  )
}


fn init(initial_count: Int) -> Model {
  Model(total_sites: initial_count, power_packs: initial_count, power_pack_micros: 0)
}

// UPDATE ----------------------------------------------------------------------

pub opaque type Msg {
  Incr
  Decr
}

fn update(model: Model, msg: Msg) -> Model {
  case msg {
    Incr -> Model(..model, power_packs: model.power_packs + 1)
    Decr -> Model(..model, power_packs: model.power_packs - 1)
  }
}

// VIEW ------------------------------------------------------------------------

fn view(model: Model) -> Element(Msg) {
  let styles = [#("width", "100vw"), #("height", "100vh"), #("padding", "1rem")]
  let count = int.to_string(model.power_packs)

  html.div([], [
    styles.elements(),
    ui.centre(
      [attribute.style(styles)],
      ui.stack([], [
        ui.button([event.on_click(Incr)], [element.text("+")]),
        html.p([attribute.style([#("text-align", "center")])], [
          element.text(count),
        ]),
        ui.button([event.on_click(Decr)], [element.text("-")]),
      ]),
    )
  ]
  )

}
