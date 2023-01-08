terraform 
terraform init
terraform apply -var-file="./dev.tfvars"
terraform destroy -var-file="./dev.tfvars"

https://www.hashicorp.com/blog/infrastructure-as-code-in-a-private-or-public-cloud

https://www.terraform.io/

Company: HippoTech
Product: CRM
Customers: Hospitality
Deploying Products (application): HCRM
Possible Deployment Scenarios:
	On-premises/VmWare/OpenStack
	Azure:
		ARM Templates
		Azure CLI/Powershell
		Azure SDK
	AWS:
		Cloudformation
		AWS CLI
		AWS SDK
	GCP:
		GCLOUD SDK
		GCLOUD CLI
###	App Architecture:

Infrastructure as Code (IaC):
	This means expressing our infra needs in the form of some template.
	While creating/realizing the infra, pass the dynamic values.
Terraform:
	IaC which runs on any virtual platform
What do we have to do
	Define your infrastructure as a template in Terraform
	Execute the template to create infrastructure.
In which Language do we need to write these templates?
	Hashicorp Configuration Language (HCL)
Here we express what we want in the template which is referred as Desired State
Now when execute terraform will try to create infra to match your Desired State.
Idempotence: This is property which states that executing once or multiple times will have the same result
For infra-provisioning we need a template which helps in meeting desired state and is idempotent.
There are two popular tools
	Terraform
	Pulumi

Windows System Setup
Ensure your os is greater or Window 10
	Softwares:
	Chocolatey https://docs.chocolatey.org/en-us/choco/setup
	Git for windows: https://git-scm.com/download/win
	Terminal: Windows Terminal : From microsoft store on windows 10
	IDE: Visual Studio Code choco install vscode -y
	Terraform: choco install terraform -y
Mac System Setup
	Ensure you install homebrew https://brew.sh/
	Git: brew install git -y
	Visual Studio Code brew install --cask visual-studio-code -y
	Terraform brew install terraform -y
Terraform Setup and configuration
	Create a new folder hello_tf and open visual studio code.
	In the visual studio code install extension terraform (hashicorpTerraform).
