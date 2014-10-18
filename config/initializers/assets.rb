# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( timelineJS/fancybox_sprite.png )
Rails.application.config.assets.precompile += %w( timelineJS/loading.gif )
Rails.application.config.assets.precompile += %w( timelineJS/blank.gif )
Rails.application.config.assets.precompile += %w( timelineJS/overlay.png )
Rails.application.config.assets.precompile += %w( timelineJS/fancybox_sprite@2x.png )