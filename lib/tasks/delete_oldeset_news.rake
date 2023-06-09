namespace :delete_news do
  desc "Delete oldest 10 news if total count is over 300"
  task delete_oldest_news: :environment do
    if News.count > 200
      News.order(date: :asc).limit(20).destroy_all
      puts "Deleted 20 oldest news"
    else
      puts "Total news count is not over 200"
    end
  end
end
