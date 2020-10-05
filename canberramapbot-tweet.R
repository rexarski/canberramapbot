canberramapbot_token <- rtweet::create_token(
  app = "canberramapbot",
  consumer_key = Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)

lon <- format(round(runif(1, 148.9321797, 149.0364454), 4), scientific = FALSE)
lat <- round(runif(1, -35.4586503, -35.2949492), 4)

img_url <- paste0(
  "https://api.mapbox.com/styles/v1/mapbox/satellite-v9/static/",
  paste0(lon, ",", lat),
  ",15,0/600x400@2x?access_token=",
  Sys.getenv("MAPBOX_PUBLIC_ACCESS_TOKEN")
)

temp_file <- tempfile()
download.file(img_url, temp_file)

rtweet::post_tweet(
  status = paste0("https://www.openstreetmap.org/#map=17/", lat, "/", lon, "/"),
  media = temp_file,
  token = canberramapbot_token
)
