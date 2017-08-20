# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create({ name: 'Star Wars' }, { name: 'Lord of the Rings' })
#   Character.create(name: 'Luke', movie: movies.first)


category = Category.find_or_create_by(
	{
		name: "jedzenie"
	}
)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "pieczywo",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "bułki",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "chleb",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "nabiał",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "mleko",
				unit: "L",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "ser",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "twaróg",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "słodycze",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "czekolada",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "baton",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "bułka słodka",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "żelki",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "lody",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)		
	subcategory = Subcategory.find_or_create_by(
		{
			name: "przekąski",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "chipsy",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "chrupki",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "paluszki",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "wędliny",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "konserowe",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "kiełbasa",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "pasztet",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "szynka",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "obiady",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "pizza",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "restauracja",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "mrożone",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "dodatki",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "ketchup",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "majonez",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "musztarda",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "sos",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "przyprawa",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "napoje",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "słodkie",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "sok",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "herbata",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
category = Category.find_or_create_by(
	{
		name: "komunikacja"
	}
)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "motocykl",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "paliwo",
				unit: "L",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "eksploatacja",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "przeglądy",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "bilety",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "miejskie",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "taxi",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "krajowe",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
category = Category.find_or_create_by(
	{
		name: "używki"
	}
)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "alkohol",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "wino",
				unit: "L",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "piwo",
				unit: "L",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "wódka",
				unit: "L",
				subcategory_id: subcategory['id']
			}
		)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "papierosy",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "gotowe",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "składniki",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
category = Category.find_or_create_by(
	{
		name: "dom"
	}
)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "środki czystości",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "płyny i proszki",
				unit: "n/d",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "stałe",
				unit: "n/d",
				subcategory_id: subcategory['id']
			}
		)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "wyposażenie",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "meble",
				unit: "n/d",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "drobne",
				unit: "n/d",
				subcategory_id: subcategory['id']
			}
		)
category = Category.find_or_create_by(
	{
		name: "osobiste"
	}
)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "higiena",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "dezodorant",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "perfumy",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "prezerwatywy",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "mydło",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "krem",
				unit: "g",
				subcategory_id: subcategory['id']
			}
		)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "ubrania",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "spodnie",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "buty",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "bielizna",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "koszulka",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "koszula",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "bluza",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "kurtka",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "dodatek",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
category = Category.find_or_create_by(
	{
		name: "narzędzia"
	}
)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "elektronarzędzia",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "sieciowe",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "akumulatorowe",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "proste",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "klucze",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "wkrętaki",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "części",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "wkręty",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
category = Category.find_or_create_by(
	{
		name: "elektornika"
	}
)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "mała",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "słuchawki",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
	subcategory = Subcategory.find_or_create_by(
		{
			name: "duża",
			category_id: category['id']
		}
	)
		product = Product.find_or_create_by(
			{
				name: "komputer",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)
		product = Product.find_or_create_by(
			{
				name: "części",
				unit: "szt.",
				subcategory_id: subcategory['id']
			}
		)



#tworzymy dla każdej kategorii podkategorię o takiej samej nazwie oraz dla
#każdej podkategorii produkt o takiej samej nazwie
categories = Category.find_each
categories.each do |category|
	subcategory = Subcategory.find_or_create_by(
		{
			name: category['name'],
			category_id: category['id']
		}
	)
	subcategories = Subcategory.find_each
	subcategories.each do |subcategory|
		product = Product.find_or_create_by(
			{
				name: subcategory['name'],
				unit: "n/d",
				subcategory_id: subcategory['id']
			}
		)
	end
end