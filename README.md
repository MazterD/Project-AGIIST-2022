Afonso Dias 93571
Fábio Sousa 93577
David Corrieia 93576

##  This Directory contains the folders and files for the Group Lab and Project works

Each folder contains the components for setting up an Infrastructure on a certain Cloud.

Those components are typically:

* Infrastructure Provisioning and Configuration files for Terraform and Ansible
* folders for specific Applications Configuration

---

# Tutorial to run this project:

### Important
Make sure that Vagrant and Oracle VM are both installed on your machine

---

## 1st PART - set up mgmt VM

In the root directory of the project run the command:

(since the VagrantFile is already set up, nothing else is required of you to do)

```vagrant up```

---

## 2nd PART - set up project settings

Enter the VM by using the command:

```vagrant ssh mgmt```

Now run the command and press "ENTER" 3 times:

```ssh-keygen -t rsa -b 4096```

After generating the keys on the /.ssh/ folder we'll copy them to the Kubernetes directory:

```cp .ssh/id* project/kubernetes-starterkit-main```

Enter the Terraform folder inside kubernetes-starterkit-main

### Some of the terraform files will need to be edited

But before that you'll need to get a license for Google Cloud Platform and create a project record the project_id

Now edit the terraform-gcp-variables.tf with the conrresponding project_id and the desired Machine type.

(It's also possible to change the gpc_zone to one closer to the user if needed) 

The next file that you will need to edit will be terraform-gcp-provider.tf but to get the json file it will be required to go configure some settings in the gcp

Start by enabling the Compute Engine API in the APIs & Services, than go to IAM & Admin/Service accounts section and click on the 3 dots on the "Actions" column in the only active service and select the manage keys option.

Now create a new private key with the .json type and after it finishes downloading put it in the kubernetes folder and copy it's name so it can be put on the terraform-gcp-provider.tf.

With this everything should be ready for the next part.

---

## 3rd PART - Terraforming

Go on the terraform folder and run these commands:

```terraform init``` (so you can install the plug-ins needed for the terraforming)

```terraform apply```(will let you see the terraform plan and if everything was executed like instructed there shouldn't be any problem and you can press "yes")

---

## 4th PART - Ansible

Still in the terraform folder run the command:

```sudo ansible-playbook ansible-gcp-servers-setup-all.yml```

it might take a while(10-15min).

After this you can try to open a browser and search "http://balancer-ip" and the app should be visible if everything went well.

The ips can be seen either in the VM section in GCP or in gcphosts

Note: Multiple Apps can be open at the same time.
