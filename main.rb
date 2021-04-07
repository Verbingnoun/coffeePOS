require 'csv'

inventory = []
loyalty = []
prices = {small: 2, medium: 3, large: 4}
sales_hash = {small: 0, medium: 0, large: 0}

def coffeeOrder(inventory, loyalty, sales_hash)
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
        order_hash[:loyalty_num] = gets.chomp
        puts "#{order_hash[:size]} #{order_hash[:type]} with #{order_hash[:sugar]} sugar and #{order_hash[:milk]} milk"
        puts "Is this order correct? yes/no/main-menu"
        response = gets.chomp.downcase
        if response == "yes"
            addToSales(order_hash[:size], sales_hash)
            updated_inventory = removeCup(inventory)
            checkLoyalty(loyalty, order_hash[:loyalty_num])
            return updated_inventory
        elsif response == "main-menu"
            return inventory
        end
    end
end

def addToSales(size, sales_hash)
    sales_hash.include?("large")
    puts "Hello"
    sleep 2
end

def removeCup(array)
    # Find cups
    result = array.find { |item| "cups" == item[:name] }
    # remove 1 cup
    result[:qty] = result[:qty] - 1
    return array
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




def checkLoyalty(array, loyalty_num)
    array.each do |item|
        if loyalty_num == item[:loyalty_number] and item[:qty] == 5
            puts "Loyalty number found"
            puts "Free Coffee! Congratulations"
            item[:qty] = 0
            sleep 5
        elsif loyalty_num == item[:loyalty_number] and item[:qty] != 5
            item[:qty] += 1
            puts "Loyalty number found"
            puts "#{5 - item[:qty]} more orders till next free coffee"
            sleep 5
            
        else 
            loyalty_num == 0
        end
    end
end


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
        inventory = coffeeOrder(inventory, loyalty, sales_hash)
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
        puts "Create or check loyalty number? check/create"
        response = gets.chomp
        if response == "check"
            puts "Enter loyalty number"
            reponse = gets.chomp
            loyalty.each do |line|
                if response == line[:loyalty_number]
                    puts "Loyalty number found"
                    puts "#{5 - line[:qty]} more orders till next free coffee"
                    sleep 3
                    return
                end
            end
        end
        elsif response == create
            puts "Please enter desired loyalty number"
            response = gets.chomp
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