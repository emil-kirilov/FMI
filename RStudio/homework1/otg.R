setwd("C:\\Users\\Emil\\Desktop\\RStudio")
all_pokemons = read.csv("pokemon.csv", header = TRUE, sep = ",", quote = "\"",dec = ".")
f_nr = 61763
set.seed(f_nr)
size = length(all_pokemons$Number)
excerpt <- sample(1:size, 600, replace=F)
pokemons_excerpt = all_pokemons[excerpt,]
head(pokemons_excerpt)
# Number, Name, Type1, Type2 - kachestveni
# Attack, Defense, Height, Weight - kolichestveni
# Attack, Defense - diskretni
# Height, Weight - neprekasnati
attach(pokemons_excerpt)
pokemons_excerpt[which.max(Height),]

pokemons_excerpt[which.min(Weight),]

powerfull_pokemons = which(Attack + Defense > 220)
pokemons_excerpt[powerfull_pokemons, ]

dr_or_fl <- which((Type1 == "Dragon" | Type1 == "Flying" | Type2 == "Dragon" | Type2 == "Flying") & Height > 1)
nrow(pokemons_excerpt[dr_or_fl, ])

secondary_types <- which(Type2 != "")
hist(Weight, col = rainbow(7), main = "Pokemons that have secondary types", xlab = "Kilogramms", ylab = "Number of pokemons")
rug(jitter(Weight))

normal_or_flying = pokemons_excerpt[which(Type1 == "Normal" | Type1 == "Fighting"), ]
barplot(table(normal_or_flying$Type1, normal_or_flying$Height), main = "Height of Normal and Fighting type pokemons", 
        xlab = "Height (cm)", ylab = "Number of pokemons", col = c("Red", "Blue"), legend.text = c("Normal", "Fighting"))
par(mfrow = c(1, 2))

normal = pokemons_excerpt[which(Type1 == "Normal"), ]
fighting = pokemons_excerpt[which(Type1 == "Fighting"), ]
summary(fighting$Height)
summary(normal$Height)
boxplot(normal_or_flying$Height ~ normal_or_flying$Type1, xaxt = "n")
axis(side = 1, at = c(6,13), labels = c("fighting","normal"))

plot(Height, Weight, xlab = "Height (m) ", ylab = "Weight (kg) ", col = "blue", cex = 0.5)
result = simple.lm(Height,Weight)
expectedWeight = result$coefficients[1] + result$coefficients[2]*2.1
expectedWeight

stripchart(scale(Defense), cex = 0.2, main = "???????????? ???? ????????????????", xlab = "????")