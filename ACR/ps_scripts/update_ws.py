import os
from azureml.core import Workspace
from azureml.core.authentication import ServicePrincipalAuthentication

service_principal_password = os.environ.get("ARM_CLIENT_SECRET")

service_principal_auth = ServicePrincipalAuthentication(
    tenant_id="ARM_TENANT_ID",
    service_principal_id="ARM_CLIENT_ID",
    service_principal_password=service_principal_password)

ws_name="azml-demo-ws-azdemo"
ws_subcsription=""
rg_name="acr_ml_demo_rg"


ws = Workspace.list(
    ws_name, auth=service_principal_auth, subscription_id=ws_subcsription, resource_group=rg_name, location=None, cloud='AzureCloud', id=None
)

print(ws)