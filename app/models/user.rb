# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string
#  name       :string
#  location   :string
#  url        :string
#  image_url  :string
#  token      :string
#  secret     :string
#  remote_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string
#

class User < ActiveRecord::Base
  validates :username, uniqueness: true
  has_many :friends, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :friend_list_schedules, through: :lists
  has_many :tweets

  def sort(params)
    tweets.where(replied: false, viewed: false).order("remote_tweet_created_at DESC").page(params[:page])
  end

  def self.importing
    true
  end

  def self.quotes
    ["1. The name of the social network was originally “Twttr,” later changed to Twitter.", "2. It took 3 years, 2 months and 1 day to get to the billionth tweet.", "3. Today it only takes one week for users to send a billion tweets.", "4. 10 tweets per second mention Starbucks.", "5. The average Twitter user has tweeted 307 times.", "6. Barack Obama’s victory tweet was the most retweeted tweet ever with more than 800K retweets.", "7. The 2012 election broke records with 31.7 million political tweets. Election Day was by far the most tweeted about event in US political history.", "8. 32% of all Internet users are using Twitter.", "9. 69% of follows on Twitter are suggested by friends.", "10. In 2012, almost 1 million accounts were added to Twitter every day.", "11. Lady Gaga – the most followed Twitterer, with almost 33 million followers – gains followers faster than Twitter adds new accounts.", "12. The USA’s 141.8 million accounts represent 27.4% of all Twitter users.", "13. 50% of Twitter users are using the social network via mobile.", "14. 2012 brought an 800% increase in top TV show tweets.", "15. Over the span of 16 days, the London Olympics generated 150 million tweets.", "16. There were 13.7 million football-related tweets during the 2012 Super Bowl, 1 million of which appeared in the game’s final 5 minutes.", "17. While the average religious leader can expect one retweet for every 500 followers, the average musician only sees one retweet for every 30,000 followers.", "18. 64% of consumers have made a purchase decision based on social content.", "19. 91% of 18-34 year olds using social media are talking about brands.", "20. 60% of U.S. smartphone owners now visit their favorite social networking sites on a daily basis, up from 54% in 2011.", "21. 46% of U.S. social media users now access platforms such as Twitter and Facebook via their mobile phone, up 9% – almost one-quarter overall – from 2011.", "22. 31% of the average smartphone owner’s Internet time is spent social networking – close to twice as much as email.", "23. Infographics added to Stumbleupon generate 746% more pageviews than other kinds of content.", "24. There are 181,354 people on Twitter who use the term “social media” in their bio.", "25. Lady Gaga, Justin Bieber and Katy Perry have more Twitter followers than the entire populations of Germany, Turkey, South Africa, Canada, Argentina and Egypt.", "26. With more than 3 million active Twitter users, Saudi Arabia, with a 300% year-on-year growth rate, ranks #1 in the world as the fastest-growing Twitter nation.", "27. 16% of U.S. Internet users are on Twitter.", "28. The average Twitter user has 126 followers.", "29. The average business has 14,709 Twitter followers.", "30. There are more devices connected to the internet than there are people on the entire planet.", "31. 340 million tweets are sent each and every day.", "32. During the “Castle in the Sky” TV screening there were 25,088 tweets per second, the most ever.", "33. The most followed brand on Twitter is YouTube with 19 million followers.", "34. 60% of Twitter users are female.", "35. On average, Twitter users spend 21 minutes monthly on Twitter.", "36. 40% of registered Twitter users have never sent a single tweet.", "37. 92% of retweets are based on interesting content.", "38. Only 26% are due to the inclusion of “please RT!” in the tweet.", "39. Between 2008 and 2011, there was a 5,000% increase in the number of employees at Twitter.", "40. The official Twitter account for Sweden is run by a different citizen every week.", "41. McDonalds employs 10 people to run their Twitter account.", "42. Everyword is a Twitter account created by Adam Parrish in December 2007 to share every word in the English language on Twitter. Since then, this account has tweeted 84k+ words.", "43. @RealTimeWWII, a Twitter accounted created by Oxford history graduate Alwyn Collinson, narrates World War II on Twitter in real time; all the tweets are manually written, with no script used.", "44. Infographics shared on Twitter get 832% more retweets than images and articles.", "45. Twitter is available in more than 25 languages, including right-to-left languages like Arabic, Farsi, Hebrew and Urdu.", "46. As of the end of 2012, Twitter has more than 200 million active users.", "47. Twitter is now worth more than $11 billion.", "48. 16% of customers use Facebook, Twitter and the other major social networks to interact with businesses.", "49. 75%, or three out of four, heads of state are utilizing Twitter.", "50. That’s a 78% increase in the number of heads of state and national governments on Twitter from 2011. Which means Twitter is taking over the world. And we’re ok with that."]
  end
end
