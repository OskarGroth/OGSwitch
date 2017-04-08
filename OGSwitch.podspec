Pod::Spec.new do |s|

s.name              = 'OGSwitch'
s.version           = '1.4'
s.summary           = 'Switch with icon'
s.homepage          = 'https://github.com/OskarGroth/OGSwitch'
s.license           = {
:type => 'MIT',
:file => 'LICENSE'
}
s.author            = {
'Oskar Groth' => 'oskar@cindori.org'
}
s.source            = {
:git => 'https://github.com/OskarGroth/OGSwitch.git',
:tag => s.version.to_s
}
s.platform     = :osx, '10.9'
s.source_files = 'OGSwitch/OGSwitch.{swift}'
s.requires_arc = true
s.screenshot   = ""
s.social_media_url = "https://twitter.com/cindoriapps"

end
