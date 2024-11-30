require "jekyll-import"
JekyllImport::Importers::WordpressDotCom.run({
  "source" => "~/Downloads/unpassaggio.wordpress.com-2024-11-30-00_40_30/mikecasey.wordpress.2024-11-30.000.xml",
  "no_fetch_images" => true,
  "assets_folder" => "assets"
})