# Load required libraries
install.packages("dplyr")
install.packages("baseballr")
install.packages("ggplot2")
library(baseballr)
library(ggplot2)
library(dplyr)


# Get Francisco Alvarez's batting statistics for the 2024 season
francisco_alvarez <- playerid_lookup(last_name = "Alvarez", first_name = "Francisco")

# Get Statcast data for Francisco Alvarez
statcast_data <- statcast_search(player_name = francisco_alvarez$key_bbref, start_date = "2024-01-01", end_date = "2024-12-31")

# Filter the Statcast data for Francisco Alvarez
francisco_alvarez_data <- statcast_data %>%
  filter(player_name == "Alvarez, Francisco")

# Define the strike zone dimensions
strike_zone <- data.frame(
  x = c(-0.708, 0.708, 0.708, -0.708, -0.708),  # Horizontal boundaries
  y = c(1.5, 1.5, 3.5, 3.5, 1.5)  # Vertical boundaries
)

# Plot the strike zone
strike_zone_plot <- ggplot() +
  geom_polygon(data = strike_zone, aes(x = x, y = y), fill = NA, color = "black") +
  xlim(-2, 2) + ylim(0, 5) +  # Adjust limits to include the strike zone
  coord_fixed() +  # Fix aspect ratio
  labs(
    title = "Francisco Alvarez's Power Map",
    x = "Horizontal Location",
    y = "Vertical Location"
  ) +
  theme_minimal()

# Add hit points to the plot
hit_points <- strike_zone_plot +
  geom_point(data = francisco_alvarez_data, aes(x = plate_x, y = plate_z, color = hit_distance_sc)) +
  scale_color_gradient(low = "blue", high = "red") +  # Color scale from blue to red
  labs(
    color = "Hit Distance"
  )

# Display the plot
hit_points
