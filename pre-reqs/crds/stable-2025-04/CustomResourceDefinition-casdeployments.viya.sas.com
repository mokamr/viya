apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    sas.com/SAS_CADENCE_DISPLAY_NAME: Stable 2025.04
    sas.com/SAS_CADENCE_DISPLAY_SHORT_NAME: Stable
    sas.com/SAS_CADENCE_DISPLAY_VERSION: "2025.04"
    sas.com/SAS_CADENCE_NAME: stable
    sas.com/SAS_CADENCE_RELEASE: "20250502.1746179164827"
    sas.com/SAS_CADENCE_VERSION: "2025.04"
    sas.com/component-name: sas-cas-operator
    sas.com/component-version: 3.57.5-20250402.1743602794216
    sas.com/version: 3.57.5
  labels:
    sas.com/admin: cluster-api
    sas.com/deployment: sas-viya
  name: casdeployments.viya.sas.com
spec:
  conversion:
    strategy: None
  group: viya.sas.com
  names:
    kind: CASDeployment
    listKind: CASDeploymentList
    plural: casdeployments
    shortNames:
      - cas
    singular: casdeployment
  scope: Namespaced
  versions:
    - name: v1alpha1
      schema:
        openAPIV3Schema:
          properties:
            apiVersion:
              type: string
            kind:
              type: string
            metadata:
              type: object
            spec:
              x-kubernetes-preserve-unknown-fields: true
            status:
              properties:
                conditions:
                  items:
                    properties:
                      message:
                        type: string
                      reason:
                        type: string
                      status:
                        type: string
                      type:
                        type: string
                    required:
                      - status
                      - type
                    type: object
                  type: array
                controllerFailed:
                  items:
                    type: boolean
                  type: array
                controllerStarted:
                  items:
                    type: boolean
                  type: array
                transferStatus:
                  properties:
                    currentInstance:
                      format: int32
                      type: integer
                    prevInstance:
                      format: int32
                      type: integer
                    stage:
                      format: int32
                      type: integer
                    transferStart:
                      format: date-time
                      type: string
                  type: object
              required:
                - conditions
                - controllerFailed
                - controllerStarted
              type: object
          type: object
      served: true
      storage: true
      subresources:
        status: {}
