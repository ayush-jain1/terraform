control "gcs" do 
  describe command('gsutil ls -L -b gs://gcs-terraform-xx) do
    its('stdout') {should match (/Storage class : ARCHIVE/)}
  end
end 