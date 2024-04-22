# Load required libraries
install.packages("dplyr")
install.packages("baseballr")
install.packages("ggplot2")
library(baseballr)
library(ggplot2)
library(dplyr)

# Get Jeff McNeil's batting statistics for the 2024 season
Jeff_McNeil <- playerid_lookup(last_name = "McNeil", first_name = "Jeff")

# Get Statcast data for Jeff McNeil
statcast_data <- statcast_search(player_name = Jeff_McNeil$key_bbref, start_date = "2024-01-01", end_date = "2024-12-31")

# Filter the Statcast data for Jeff McNeil
Jeff_McNeil_data <- statcast_data %>%
  filter(batter == Jeff_McNeil$mlbam_id)

# Define the strike zone dimensions for a left-handed batter
strike_zone_left_handed <- data.frame(
  x = c(0.708, -0.708, -0.708, 0.708, 0.708),  # Horizontal boundaries (reflected)
  y = c(1.5, 1.5, 3.5, 3.5, 1.5)  # Vertical boundaries
)

# Plot the strike zone
strike_zone_plot <- ggplot() +
  geom_polygon(data = strike_zone_left_handed, aes(x = x, y = y), fill = NA, color = "black") +
  xlim(-2, 2) + ylim(0, 5) +  # Adjust limits to include the strike zone
  coord_fixed() +  # Fix aspect ratio
  labs(
    title = "Jeff McNeil's Power Map",
    x = "Horizontal Location",
    y = "Vertical Location"
  ) +
  theme_minimal()

# Add hit points to the plot
hit_points <- strike_zone_plot +
  geom_point(data = Jeff_McNeil_data, aes(x = plate_x, y = plate_z, color = hit_distance_sc)) +
  scale_color_gradient(low = "blue", high = "red") +  # Color scale from blue to red
  labs(
    color = "Hit Distance"
  )

# Display the plot
hit_points






