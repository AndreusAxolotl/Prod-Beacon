require ("util")
require("__base__/prototypes/entity/pipecovers")
require ("circuit-connector-sprites")
require("__base__/prototypes/entity/assemblerpipes")
local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")
local movement_triggers = require("__base__/prototypes/entity/movement-triggers")
local cargo_pod_procession_catalogue = require("__base__/prototypes/entity/cargo-pod-catalogue")
local space_age_sounds = require("__space-age__.prototypes.entity.sounds")
local item_sounds = require("__base__.prototypes.item_sounds")
local space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
local item_tints = require("__base__.prototypes.item-tints")
local item_effects = require("__space-age__.prototypes.item-effects")
local meld = require("meld")
local simulations = require("__space-age__.prototypes.factoriopedia-simulations")

data:extend {{
    type = "item",
    name = "prod-prod-beacon",
    subgroup = "module",
    inventory_move_sound = item_sounds.metal_large_inventory_move,
    pick_sound = item_sounds.metal_large_inventory_pickup,
    drop_sound = item_sounds.metal_large_inventory_move,
    icon = "__Prod-Beacon__/graphics/icons/prod-beacon.png",
    icon_size = 64,
    stack_size = 20,
    default_import_location = "nauvis",
    weight = 200000,
    place_result = "prod-prod-beacon"
}}
data:extend {{
    type = "recipe",
    name = "prod-prod-beacon",
    enabled = false,
    energy_required = 25,
    ingredients = {
        {type = "item", name = "steel-plate",   amount = 25},
        {type = "item", name = "productivity-module-3",       amount = 5},
        {type = "item", name = "beacon", amount = 1},
    },
    results = {
        {type = "item", name = "prod-prod-beacon", amount = 1}
    },
    allow_productivity = false,
    main_product = "prod-prod-beacon",
    category = "crafting",
    auto_recycle = true
}}

data:extend(
{
  {
    type = "fuel-category",
    name = "prod-production-juice"
  }
}
)

data.raw.module["productivity-module"].fuel_category = "prod-production-juice"
data.raw.module["productivity-module-2"].fuel_category = "prod-production-juice"
data.raw.module["productivity-module-3"].fuel_category = "prod-production-juice"
data.raw.module["productivity-module"].burnt_result = "advanced-circuit"
data.raw.module["productivity-module-2"].burnt_result = "advanced-circuit"
data.raw.module["productivity-module-3"].burnt_result = "advanced-circuit"
data.raw.module["productivity-module"].fuel_value = "4MJ"
data.raw.module["productivity-module-2"].fuel_value = "6MJ"
data.raw.module["productivity-module-3"].fuel_value = "10MJ"

data:extend{
    {
        type = "technology",
        name = "prod-prod-beacon",
        icon = "__Prod-Beacon__/graphics/technology/prod-beacon.png",
        icon_size = 256,
        effects =
        {
          {
            type = "unlock-recipe",
            recipe = "prod-prod-beacon"
          },
        },
        prerequisites = {"effect-transmission", "productivity-module-3"},
        unit =
{
count = 500,
ingredients =
{
{"automation-science-pack", 1},
{"logistic-science-pack", 1},
{"chemical-science-pack", 1},
{"production-science-pack", 1},
},
time = 30
}
      }
    }

data:extend{
    {
        name = "prod-prod-beacon",
        type = "beacon",
        icon = "__Prod-Beacon__/graphics/icons/prod-beacon.png",
        icon_size = 64,
        flags = {"placeable-neutral", "placeable-player", "player-creation"},
        minable = {
          mining_time = 0.5,
          results = {{type="item", name="prod-prod-beacon", amount=1}}
        },
        max_health = 200,
        corpse = "medium-remnants",
        dying_explosion = "medium-explosion",
        collision_box = {{-1.1, -1.1}, {1.1, 1.1}},
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        energy_source =
        {
            type = "burner",
            fuel_categories = {"prod-production-juice"},
            fuel_inventory_size = 1,
            emissions_per_minute = { pollution = 30 },
            effectivity = 0.2,
            burnt_inventory_size = 1,
        },
        energy_usage = "500kW",
        heating_energy = "200kW",
        module_slots = 1,
        supply_area_distance = 3,
        distribution_effectivity = 3,
        distribution_effectivity_bonus_per_quality_level = 1,
        allowed_module_categories = {"productivity"},
        allowed_effects = {"consumption", "speed", "pollution", "productivity"},
        profile = {1.00, 0.5, 0.3333, 0.25, 0.2, 0.1667, 0.1429, 0.125, 0.1111, 0.1, 0.0909, 0.0833, 0.0769, 0.0714, 0.0667, 0.0625, 0.0588, 0.0556, 0.0526, 0.05, 0.0476, 0.0455, 0.0435, 0.0417, 0.04, 0.0385, 0.037, 0.0357, 0.0345, 0.0333, 0.0323, 0.0312, 0.0303, 0.0294, 0.0286, 0.0278, 0.027, 0.0263, 0.0256, 0.025, 0.0244, 0.0238, 0.0233, 0.0227, 0.0222, 0.0217, 0.0213, 0.0208, 0.0204, 0.02, 0.0196, 0.0192, 0.0189, 0.0185, 0.0182, 0.0179, 0.0175, 0.0172, 0.0169, 0.0167, 0.0164, 0.0161, 0.0159, 0.0156, 0.0154, 0.0152, 0.0149, 0.0147, 0.0145, 0.0143, 0.0141, 0.0139, 0.0137, 0.0135, 0.0133, 0.0132, 0.013, 0.0128, 0.0127, 0.0125, 0.0123, 0.0122, 0.012, 0.0119, 0.0118, 0.0116, 0.0115, 0.0114, 0.0112, 0.0111, 0.011, 0.0109, 0.0108, 0.0106, 0.0105, 0.0104, 0.0103, 0.0102, 0.0101, 0.01},
        beacon_counter = "same_type",
        open_sound = {filename = "__base__/sound/open-close/beacon-open.ogg", volume = 0.4},
    close_sound = {filename = "__base__/sound/open-close/beacon-close.ogg", volume = 0.4},
    animation = {
      layers = {
        {
          filename = "__Prod-Beacon__/graphics/entity/prod-beacon/prod-beacon-shadow.png",
          priority = "high",
          width = 400,
          height = 350,
          frame_count= 1,
          line_length = 1,
          repeat_count = 20,
          animation_speed = 0.5,
          shift = util.by_pixel(0, -16),
          draw_as_shadow = true,
          scale = 0.5
      },
          {
              priority = "high",
              width = 160,
              height = 290,
              frame_count = 20,
              animation_speed = 0.5,
              scale = 0.5,
              shift = util.by_pixel(0, -26),
              stripes = {
                  {
                      filename = "__Prod-Beacon__/graphics/entity/prod-beacon/prod-beacon-animation.png",
                      width_in_frames = 8,
                      height_in_frames = 3,
                  },
              },
          },
          {
              priority = "high",
              width = 160,
              height = 290,
              frame_count = 20,
              draw_as_glow = true,
              scale = 0.5,
              animation_speed = 0.5,
              blend_mode = "additive",
              shift = util.by_pixel(0, -26),
              stripes = {
                  {
                      filename = "__Prod-Beacon__/graphics/entity/prod-beacon/prod-beacon-emission.png",
                      width_in_frames = 8,
                      height_in_frames = 3,
                  },
              },
          },
      },
  },
  radius_visualisation_picture =
  {
    filename = "__base__/graphics/entity/beacon/beacon-radius-visualization.png",
    priority = "extra-high-no-scale",
    width = 10,
    height = 10
  }, 
  working_sound =
        {
          sound = {filename = "__base__/sound/combinator.ogg", volume = 0.3},
          apparent_volume = 0.3,
        },
        created_effect = {
          type = "direct",
          action_delivery = {
            type = "instant",
            source_effects = {
              {
                type = "script",
                effect_id = "prod-prod-beacon-created",
              },
            }
          }
        },
      }
}
         
        
