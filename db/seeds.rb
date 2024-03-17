# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Investment.create(title: 'Sustainable Chicken Coop Expansion', amount: 5, description: 'Support the expansion of our chicken coop facility to accommodate more birds and ensure their well-being.')
Investment.create(title: 'Organic Feed Investment', amount: 5, description: 'Contribute to the purchase of high-quality organic feed that promotes the health and growth of our chickens.')
Investment.create(title: 'Smart Monitoring System Implementation', amount: 7, description: 'Invest in cutting-edge technology that allows us to monitor our chickens’ health and environment in real-time.')
Investment.create(title: 'Market Outreach and Distribution', amount: 15, description: 'Help us establish strong market connections and distribution channels to ensure successful product placement and sales.')
Investment.create(title: 'Energy-Efficient Lighting Upgrade', amount: 3, description: 'Support the installation of energy-efficient lighting systems in our facility, reducing operating costs.')
Investment.create(title: 'Employee Training and Development', amount: 2, description: 'Invest in comprehensive training programs for our dedicated staff to enhance their skills and productivity.')
Investment.create(title: 'Chick Acquisition and Rearing', amount: 8, description: 'Contribute to the acquisition of chicks and their early-stage rearing, laying the foundation for a profitable venture.')
Investment.create(title: 'Veterinary Care and Health Management', amount: 4, description: 'Help us maintain the well-being of our chickens through regular veterinary care and health management practices.')
Investment.create(title: 'Packaging and Branding Enhancement', amount: 6, description: 'Support the improvement of our product packaging and branding, making our products stand out in the market.')
Investment.create(title: 'Sustainable Practices Research and Development', amount: 12, description: 'Invest in ongoing research to innovate and implement sustainable practices that promote environmental responsibility.')

Farmer.create(name: 'Wanjohi', contact: '254727538865')
Farmer.create(name: 'Tola', contact: '254727538865')
Farmer.create(name: 'Adensami', contact: '254727538865')
Farmer.create(name: 'Wambui', contact: '254727538865')
Farmer.create(name: 'Wanyama', contact: '254727538865')
Farmer.create(name: 'Abdul', contact: '254727538865')
Farmer.create(name: 'Rashid', contact: '254727538865')
Farmer.create(name: 'Trevor', contact: '254727538865')
Farmer.create(name: 'Bola', contact: '254727538865')
Farmer.create(name: 'Koja', contact: '254727538865')
