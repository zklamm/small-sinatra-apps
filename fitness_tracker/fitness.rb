require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

LBS_PER_KG = 0.453592
IN_PER_CM = 2.54

CALORIES_PER_PROT = 4
CALORIES_PER_CARB = 4
CALORIES_PER_FATS = 9

PERCENT_PROT = 0.25
PERCENT_CARB = 0.4
PERCENT_FATS = 0.35

DEFICIT = 0.2

def tdee(weight, height, age, gender, activity_level)
  bmr = 10 * weight * LBS_PER_KG + 6.25 * height * IN_PER_CM - 5 * age + 5
  if gender.downcase.start_with?('m')
    bmr * activity_level
  else
    (bmr - 166) * activity_level
  end
end

def macros(calories)
  calories = calories * (1 - DEFICIT)
  prot = calories / CALORIES_PER_PROT * PERCENT_PROT
  carb = calories / CALORIES_PER_CARB * PERCENT_CARB
  fats = calories / CALORIES_PER_FATS * PERCENT_FATS

  [prot.ceil, carb.ceil, fats.ceil]
end

get '/' do
  @users = 
  erb :index
end
