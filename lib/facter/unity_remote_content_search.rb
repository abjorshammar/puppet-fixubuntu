Facter.add("unity_remote_content_search") do
  setcode do
    schema = Facter::Util::Resolution.exec("/usr/bin/gsettings list-schemas | grep -i com.canonical.Unity.Lenses | head -1")
    Facter::Util::Resolution.exec("/usr/bin/gsettings get #{schema} remote-content-search").tr("'","")
  end
end
