# Load required libraries
install.packages("dplyr")
install.packages("baseballr")
install.packages("ggplot2")
library(baseballr)
library(ggplot2)
library(dplyr)

# Get Harrison Bader's batting statistics for the 2024 season
harrison_bader <- playerid_lookup(last_name = "Bader", first_name = "Harrison")

# Get Statcast data for Harrison Bader
statcast_data <- statcast_search(player_name = harrison_bader$key_bbref, start_date = "2024-01-01", end_date = "2024-12-31")

# Filter the Statcast data for Harrison Bader
harrison_bader_data <- statcast_data %>%
  filter(batter == harrison_bader$mlbam_id)

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
    title = "Harrison Bader's Power Map",
    x = "Horizontal Location",
    y = "Vertical Location"
  ) +
  theme_minimal()

# Add hit points to the plot
hit_points <- strike_zone_plot +
  geom_point(data = harrison_bader_data, aes(x = plate_x, y = plate_z, color = hit_distance_sc)) +
  scale_color_gradient(low = "blue", high = "red") +  # Color scale from blue to red
  labs(
    color = "Hit Distance"
  )

# Display the plot
hit_points






