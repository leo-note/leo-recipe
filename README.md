# テーブル設計

## users テーブル
| Column                 | Type     | Options                         |
| -----------------------|----------|-------------------------------- |
| nickname               | string   | null:false                      |
| email                  | string   | null:false, unique:true         |
| encrypted_password     | string   | null:false                      |

### association
- has_many :recipes
- has_one :profile
- has_one :clip
- has_many :comments
- has_many :present_orders

## recipes テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| title                  | string     | null:false                    |
| category_id            | integer    | null:false                    |
| text                   | text       | null:false                    |
| user                   | references | null: false,foreign_key: true |

### association
- belongs_to :user
- has_many :comments
- has_many :recipe_materials
- has_many :materials, through: :recipe_materials
- has_many :clip_recipes
- has_many :clips, through: :clip_recipes

### Other
- using ActiveStorage and ActiveHash(category)

## recipe_materials テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| recipe                 | references | null: false,foreign_key: true |
| material               | references | null: false,foreign_key: true |

### association
- belongs_to :recipe
- belongs_to :material

## materials テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| name                   | string     | null: false                   |
| roman_name             | string     | null: false                   |

### association
- has_many :recipe_materials
- has_many :recipes, through: :recipe_materials
- has_many :allergy_materials
- has_many :allergies, through: :allergy_materials

## clips テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| user                   | references | null: false,foreign_key: true |

### association 
- belongs_to :user
- has_many :clip_recipes
- has_many :recipes, through: :clip_recipes

## clip_recipes テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| clip                   | references | null: false,foreign_key: true |
| recipe                 | references | null: false,foreign_key: true |

### association
- belongs_to :clip
- belongs_to :recipe

## profiles テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| gender_id              | integer    | null:false                    |
| family_structure_id    | integer    | null:false                    |
| taste_id               | integer    | null:false                    | 
| user                   | references | null: false,foreign_key: true |

### association
- belongs_to :user
- has_one :allergy

### Other
- using ActiveHash(gender,family_structure,taste)

## allergy テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| profile                | references | null: false,foreign_key: true |

### association 
- belongs_to :profile
- has_many :allergy_materials
- has_many :materials, through: :allergy_materials

## allergy_materials テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| allergy                | references | null: false,foreign_key: true |
| material               | references | null: false,foreign_key: true |

### association
- belongs_to :allergy
- belongs_to :material

## comments テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| text                   | text       | null:false                    |
| user                   | references | null: false,foreign_key: true |
| recipe                 | references | null: false,foreign_key: true |

### association
- belongs_to :user
- belongs_to :recipe

## present_orders　テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| present_id             | integer    | null:false                    |
| user                   | references | null: false,foreign_key: true |

### association
- belongs_to :user
- has_one :delivery_address

### Other
- using ActiveHash(present)

## delivery_addresses　テーブル
| Column                 | Type       | Options                       |
| -----------------------|------------|------------------------------ |
| last_name              | string     | null:false                    |
| first_name             | string     | null:false                    |
| last_name_kana         | string     | null:false                    |
| first_name_kana        | string     | null:false                    |
| postal_code            | string     | null:false                    |
| prefecture_id          | integer    | null:false                    |
| city                   | string     | null:false                    |
| address                | string     | null:false                    |
| building_name          | string     |                               |
| phone_number           | string     | null:false                    |
| present_orser          | references | null: false,foreign_key: true |

### association
- belongs_to :present_order

### Other
- using ActiveHash(prefecture)