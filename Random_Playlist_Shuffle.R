### Simple Fisher - Yates algorithm to Shuffle Songs and Why its not ideal

# We create a random playlist of some number songs we also randomly assign them genres from A to D

number_songs = 20
songs = seq(1,number_songs)

genres = round(runif(number_songs,min = 1,max = 4))
genres = replace(genres, genres == 1,"A")
genres = replace(genres, genres == 2,"B")
genres = replace(genres, genres == 3,"C")
genres = replace(genres, genres == 4,"D")
genres

playlist = cbind.data.frame(songs,genres)

playlist_length = length(playlist[,1])
shuffled_playlist = playlist

for (i in seq(1,playlist_length-1)) {
  
  j = sample(x = seq(1,i), size = 1)
  
  shuffled_playlist[c(i,j),1] = shuffled_playlist[c(j,i),1]

  }

# Just by looking at individual songs it looks like the shuffle worked
library(ggplot2)

p1 =  qplot(y = shuffled_playlist[,1], x = seq(1,number_songs),geom = "point",
      main = c("Shuffled Song Positions"),xlab = "Position",ylab = "Song Number")

p1
# But if we add the genres to the mix we can see a problem appearing, songs from the same genre keep repeating
# You can run the code a several times and will see that the same problem keeps reappearing

p2 =  qplot(x = shuffled_playlist[,1], y = seq.int(1,1,length.out = number_songs),
            geom = "point",color = shuffled_playlist[,2],
            main = "Shuffled Song Genres",xlab = "Position",ylab = "") + geom_point(size = 5) + guides(color = guide_legend(title = "Genres"))
p2

 