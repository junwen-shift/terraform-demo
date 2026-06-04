output "pet_name" {
  description = "Generated pet name"
  value       = random_pet.main.id
}

output "random_id" {
  description = "Generated random hex ID"
  value       = random_id.main.hex
}

output "metadata_file" {
  description = "Path to the generated metadata file"
  value       = local_file.metadata.filename
}
