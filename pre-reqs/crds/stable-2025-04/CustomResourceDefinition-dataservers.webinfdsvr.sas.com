---
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.17.2
    sas.com/SAS_CADENCE_DISPLAY_NAME: Stable 2025.04
    sas.com/SAS_CADENCE_DISPLAY_SHORT_NAME: Stable
    sas.com/SAS_CADENCE_DISPLAY_VERSION: "2025.04"
    sas.com/SAS_CADENCE_NAME: stable
    sas.com/SAS_CADENCE_RELEASE: "20250502.1746179164827"
    sas.com/SAS_CADENCE_VERSION: "2025.04"
    sas.com/component-name: sas-data-server-operator
    sas.com/component-version: 22.16.0-20250407.1744051277977
    sas.com/version: 22.16.0
  labels:
    sas.com/admin: cluster-api
    sas.com/deployment: sas-viya
  name: dataservers.webinfdsvr.sas.com
spec:
  group: webinfdsvr.sas.com
  names:
    kind: DataServer
    listKind: DataServerList
    plural: dataservers
    singular: dataserver
  scope: Namespaced
  versions:
    - additionalPrinterColumns:
        - jsonPath: .metadata.creationTimestamp
          name: Age
          type: date
      name: v1beta1
      schema:
        openAPIV3Schema:
          description: DataServer is the Schema for the Dataservers API
          properties:
            apiVersion:
              description: |-
                APIVersion defines the versioned schema of this representation of an object.
                Servers should convert recognized schemas to the latest internal value, and
                may reject unrecognized values.
                More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
              type: string
            kind:
              description: |-
                Kind is a string value representing the REST resource this object represents.
                Servers may infer this from the endpoint the client submits requests to.
                Cannot be updated.
                In CamelCase.
                More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
              type: string
            metadata:
              type: object
            spec:
              properties:
                databases:
                  items:
                    properties:
                      accessTypes:
                        items:
                          type: string
                        type: array
                      desiredState:
                        type: string
                      name:
                        type: string
                      outputs:
                        items:
                          properties:
                            outputType:
                              type: string
                            patternName:
                              type: string
                            patternValues:
                              additionalProperties:
                                type: string
                              type: object
                          type: object
                        type: array
                      owner:
                        type: string
                      scripts:
                        items:
                          properties:
                            patternName:
                              type: string
                            patternValues:
                              additionalProperties:
                                type: string
                              type: object
                          type: object
                        type: array
                    required:
                      - name
                    type: object
                  type: array
                registrations:
                  items:
                    properties:
                      dataServiceName:
                        type: string
                      desiredState:
                        type: string
                      host:
                        type: string
                      patternName:
                        type: string
                      patternValues:
                        additionalProperties:
                          type: string
                        type: object
                      port:
                        type: integer
                      registrationType:
                        type: string
                      serviceName:
                        description: optional, defaults to metadata.name
                        type: string
                      tags:
                        items:
                          type: string
                        type: array
                    type: object
                  type: array
                ssl:
                  type: boolean
                users:
                  items:
                    properties:
                      accessTypes:
                        items:
                          type: string
                        type: array
                      credentials:
                        properties:
                          input:
                            properties:
                              inputType:
                                type: string
                              passwordKey:
                                type: string
                              patternName:
                                type: string
                              patternValues:
                                additionalProperties:
                                  type: string
                                type: object
                              scripts:
                                items:
                                  properties:
                                    patternName:
                                      type: string
                                    patternValues:
                                      additionalProperties:
                                        type: string
                                      type: object
                                  type: object
                                type: array
                              secretRef:
                                description: |-
                                  LocalObjectReference contains enough information to let you locate the
                                  referenced object inside the same namespace.
                                properties:
                                  name:
                                    default: ""
                                    description: |-
                                      Name of the referent.
                                      This field is effectively required, but due to backwards compatibility is
                                      allowed to be empty. Instances of this type with an empty value here are
                                      almost certainly wrong.
                                      More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
                                    type: string
                                type: object
                                x-kubernetes-map-type: atomic
                              usernameKey:
                                type: string
                            type: object
                          outputs:
                            items:
                              properties:
                                outputType:
                                  type: string
                                patternName:
                                  type: string
                                patternValues:
                                  additionalProperties:
                                    type: string
                                  type: object
                              type: object
                            type: array
                        required:
                          - input
                        type: object
                      desiredState:
                        type: string
                      name:
                        type: string
                    required:
                      - credentials
                      - name
                    type: object
                  type: array
              required:
                - databases
                - registrations
                - ssl
                - users
              type: object
            status:
              description: DataServerStatus defines the observed state of DataServer
              type: object
          type: object
      served: true
      storage: true
      subresources:
        status: {}
