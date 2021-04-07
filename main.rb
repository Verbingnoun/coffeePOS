require 'csv'

inventory = []
loyalty = []
prices = {small: 2, medium: 3, large: 4}
sales = {small: 0, medium: 0, large: 0}

def coffeeOrder(inventory, loyalty)
    order_hash = {}
    loop do
        puts "\e[H\e[2J"
        puts "What type of coffee?"
        order_hash[:type] = gets.chomp.downcase
        puts "What size?"
        order_hash[:size] = gets.chomp.downcase
        puts "Milk?"
        order_hash[:milk] = gets.chomp.downcase
        puts "Sugar?"
        order_hash[:sugar] = gets.chomp.downcase
        puts "Enter loyalty card number if available, else type no"
        order_hash[:loyalty_num] = gets.chomp.to_i
        p order_hash
        puts "Is this order correct? yes/no/main-menu"
        response = gets.chomp.downcase
        if response == "yes"
            updated_inventory = removeCup(inventory)
            # checkLoyalty(loyalty, loyalty_num)
            return updated_inventory
        elsif response == "main-menu"
            return inventory
        end
    end
end

def removeCup(array)
    # Find cups
    result = array.find { |item| "cups" == item[:name] }
    # remove 1 cup
    result[:qty] = result[:qty] - 1
    return array
end

def removeMilk(array)
    #Find cups
    result = array.find {|item| "milk" == item[:name] }
    #remove 1 cup
    result[:qty] = result[:qty] - 1
    return array
end

def removeBeans(array)
    #Find cups
    result = array.find {|item| "beans" == item[:name] }
    #remove 1 cup
    result[:qty] = result[:qty] - 1
    return array
end




def checkLoyalty(array, loyalty)
    result = array.each do |item|
        if  loyalty ==  item[:loyalty_number]
            result[:qty] + 1
             if result[:qty] == 5
                puts "Free 5th Coffee"
                sleep 5
                result[:qty] = 0
            end
        end
    end
end

# def displayLoyalty(inventory,loyalty)
#     puts "\e[H\e[2J"
#     puts "Enter loyalty number"
#     result = gets.chomp.to_i
#     loyalty.each do |item|
#     end
# end

def endofDay
    #  write inventory array to inventory.csv
    CSV.open('./csv/inventory.csv', "w") do |csv|
         inventory.each do |item|
        csv << [item[:name], item[:qty]]
        end
    end
end

#open inventory.csv and save to array
CSV.open("./csv/inventory.csv") do |csv|
    csv.each do |line| 
        inventory.push({name: line[0], qty: line[1].to_i})
    end
end

#open loyalty.csv and save to array
CSV.open("./csv/loyalty.csv") do |csv|
    csv.each do |line|
        loyalty.push({loyalty_number: line[0], qty: line[1].to_i})
    end
end


puts "Welcome to CoffeePOS!"


user_exit = false
until user_exit
    puts "\e[H\e[2J"
    puts "-----------------------------------------------------------------"
    puts "1. New Order   2. Inventory  3. Loyalty Program  4. End of day"
    puts "Enter the number of the option you would like"
    puts "-----------------------------------------------------------------"
    action = gets.chomp.downcase 
    if action == "1"
        inventory = coffeeOrder(inventory, loyalty)
    elsif action == "2"
        puts "\e[H\e[2J"
        inventory.each do |line|
            puts "You have #{line[:qty]} units of #{line[:name]}"
        end
        puts "--------------------------------------"
        puts "         Options"
        puts "1. Edit Inventory 2. Main Menu"
        puts "--------------------------------------"
        input = gets.chomp
        if input == "1"
            #Execute edit method
        end
    elsif action == "3"
        puts "\e[H\e[2J"
        puts "Enter loyalty number"
        result = gets.chomp.to_i
        # loyalty.each do |item|
    elsif action == "4"
        user_exit = true
    else
        puts "Please enter 1, 2, 3 or 4"
    end
end




# #Find cups in inventory
# result = inventory.find {|item| "cups" == item[:name] }

# #remove 1 cup
# result[:qty] = result[:qty] - 1

# #write inventory array to inventory.csv
# CSV.open('./csv/inventory.csv', "w") do |csv|
#     inventory.each do |item|
#         csv << [item[:name], item[:qty]]
#     end