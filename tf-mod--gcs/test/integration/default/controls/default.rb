control "gcs" do 
  describe command('gsutil ls -L -b gs://test-tf-state-upgradee') do
    its('stdout') {should match (/Storage class : ARCHIVE/)}
  end
end 