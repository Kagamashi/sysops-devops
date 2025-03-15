variable hotel_transylvania_characters {
  type = list(object({
    like = bool
    name = string
  }))
  default = [
    { like = true,  name = "drac"   },
    { like = true,  name = "mavis"  },
    { like = false, name = "muray"  },
    { like = true,  name = "frank"  },
    { like = false, name = "eunice" },
    { like = true,  name = "wayne"  },
    { like = true,  name = "wanda"  },
    { like = true,  name = "weenie" },
  ]
}

output result {
  value = { for character in [for c in var.hotel_transylvania_characters: c if c.like == true]: character.name => character }
}

# result = {
#  drac = {
#    name = "drac"
#    like = true
#  }
#  mavis = {
#    name = "mavis"
#    like = true
#  }
#  frank = {
#    name = "frank"
#    like = true
#  }
#  wayne = {
#    name = "wayne"
#    like = true
#  }
#  wanda = {
#    name = "wanda"
#    like = true
#  }
#  weenie = {
#    name = "weenie"
#    like = true
#  }
#}
