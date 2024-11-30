require 'nokogiri'
require 'date'
require 'fileutils'

xml_file = File.expand_path('~/Downloads/unpassaggio.wordpress.com-2024-11-30-00_40_30/mikecasey.wordpress.2024-11-30.000.xml')
doc = File.open(xml_file) { |f| Nokogiri::XML(f) }

FileUtils.mkdir_p('_posts')

doc.css('item').each do |item|
  title = item.at_css('title').content
  date = DateTime.parse(item.at_css('pubDate').content)
  content = item.at_css('content|encoded', 'content' => 'http://purl.org/rss/1.0/modules/content/')&.content
  status = item.at_css('wp|status', 'wp' => 'http://wordpress.org/export/1.2/')&.content

  next unless status == 'publish' && content

  # Create filename
  filename = "_posts/#{date.strftime('%Y-%m-%d')}-#{title.downcase.gsub(/[^a-z0-9]+/, '-')}.md"

  # Create post content
  post_content = "---\n"
  post_content += "layout: post\n"
  post_content += "title: \"#{title}\"\n"
  post_content += "date: #{date.strftime('%Y-%m-%d %H:%M:%S %z')}\n"
  post_content += "---\n\n"
  post_content += content

  File.write(filename, post_content)
  puts "Created #{filename}"
end