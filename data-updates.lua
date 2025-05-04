local function add_tech_effect(tech_name, effect)
    local tech = data.raw.technology[tech_name]
    tech.effects = tech.effects or {}
    table.insert(tech.effects, effect)
  end

  local function add_crafting_categories(entity_type, entity_name, categories)
    local entity = data.raw[entity_type][entity_name]
    for _,category in pairs(categories) do
      table.insert(entity.crafting_categories, category)
    end
  end

  local function add_tech_prerequisites(tech_name, prerequisites)
    local tech = data.raw.technology[tech_name]
    tech.prerequisites = tech.prerequisites or {}
    for _, prereq in ipairs(tech.prerequisites) do
      if prereq == prerequisites then
        return
      end
    end
    table.insert(tech.prerequisites, prerequisites)
  end

  local function add_science_pack(tech_name, science_pack)
    local tech = data.raw.technology[tech_name]
    tech.unit.ingredients = tech.unit.ingredients or {}
    table.insert(tech.unit.ingredients, science_pack)
  end

  local function add_player_crafting_categories(categories)
    local entity = data.raw.character.character
    for _,category in pairs(categories) do
      table.insert(entity.crafting_categories, category)
    end
  end

if mods["space-age"] then 
    add_science_pack("prod-prod-beacon", {"space-science-pack", 1})
    add_science_pack("prod-prod-beacon", {"electromagnetic-science-pack", 1})
    add_science_pack("prod-prod-beacon", {"agricultural-science-pack", 1})
    add_tech_prerequisites("prod-prod-beacon", "electromagnetic-science-pack")
end
if feature_flags["freezing"] then
  data.raw["beacon"]["prod-prod-beacon"].heating_energy = "500kW"
end
if mods["Age-of-Production"] then 
    add_tech_prerequisites("prod-prod-beacon", "aop-smaller-beacons")
    data.raw.recipe["prod-prod-beacon"].ingredients = {
      {type = "item", name = "steel-plate",   amount = 25},
      {type = "item", name = "productivity-module-3",       amount = 5},
      {type = "item", name = "aop-transmitter", amount = 5},
                    }
end