require 'nokogiri'
require 'date'

# Read the WordPress export file
xml_content = File.read(File.expand_path('~/Downloads/unpassaggio.wordpress.com-2024-11-30-00_40_30/mikecasey.wordpress.2024-11-30.000.xml'))
doc = Nokogiri::XML(xml_content)

# Create _posts directory if it doesn't exist
Dir.mkdir('_posts') unless Dir.exist?('_posts')

# Process each post
doc.xpath('//item').each do |item|
  next unless item.at_xpath('.//wp:post_type', 'wp' => "http://wordpress.org/export/1.2/").content == 'post'
  next unless item.at_xpath('.//wp:status', 'wp' => "http://wordpress.org/export/1.2/").content == 'publish'

  title = item.at_xpath('title').content
  date = DateTime.parse(item.at_xpath('pubDate').content)
  content = item.at_xpath('content:encoded', 'content' => "http://purl.org/rss/1.0/modules/content/").content

  # Create filename
  slug = title.downcase.gsub(/[^a-z0-9]+/, '-')
  filename = "_posts/#{date.strftime('%Y-%m-%d')}-#{slug}.md"

  # Create post content with front matter
  post_content = <<~CONTENT
    ---
    layout: post
    title: "#{title}"
    date: #{date.strftime('%Y-%m-%d %H:%M:%S %z')}
    ---

    #{content}
  CONTENT

  File.write(filename, post_content)
  puts "Created #{filename}"
end