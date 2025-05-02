---
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.14.0
    sas.com/SAS_CADENCE_DISPLAY_NAME: Stable 2025.04
    sas.com/SAS_CADENCE_DISPLAY_SHORT_NAME: Stable
    sas.com/SAS_CADENCE_DISPLAY_VERSION: "2025.04"
    sas.com/SAS_CADENCE_NAME: stable
    sas.com/SAS_CADENCE_RELEASE: "20250502.1746179164827"
    sas.com/SAS_CADENCE_VERSION: "2025.04"
    sas.com/component-name: sas-opendistro-operator
    sas.com/component-version: 7.47.0-20250404.1743774225519
    sas.com/version: 7.47.0
  labels:
    sas.com/admin: cluster-api
    sas.com/deployment: sas-viya
  name: opendistroclusters.opendistro.sas.com
spec:
  group: opendistro.sas.com
  names:
    kind: OpenDistroCluster
    listKind: OpenDistroClusterList
    plural: opendistroclusters
    shortNames:
      - odc
    singular: opendistrocluster
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
              properties:
                auditLogRetention:
                  default:
                    enableISMPolicyHistory: true
                    enableIndexCleanup: true
                    indexRetentionPeriod: 7d
                    ismLogRetentionPeriod: 7d
                    ismPriority: 50
                  properties:
                    enableISMPolicyHistory:
                      type: boolean
                    enableIndexCleanup:
                      type: boolean
                    indexRetentionPeriod:
                      type: string
                    ismLogRetentionPeriod:
                      type: string
                    ismPriority:
                      type: integer
                  type: object
                config:
                  properties:
                    env:
                      items:
                        properties:
                          name:
                            type: string
                          value:
                            type: string
                          valueFrom:
                            properties:
                              configMapKeyRef:
                                properties:
                                  key:
                                    type: string
                                  name:
                                    default: ""
                                    type: string
                                  optional:
                                    type: boolean
                                required:
                                  - key
                                type: object
                                x-kubernetes-map-type: atomic
                              fieldRef:
                                properties:
                                  apiVersion:
                                    type: string
                                  fieldPath:
                                    type: string
                                required:
                                  - fieldPath
                                type: object
                                x-kubernetes-map-type: atomic
                              resourceFieldRef:
                                properties:
                                  containerName:
                                    type: string
                                  divisor:
                                    anyOf:
                                      - type: integer
                                      - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                  resource:
                                    type: string
                                required:
                                  - resource
                                type: object
                                x-kubernetes-map-type: atomic
                              secretKeyRef:
                                properties:
                                  key:
                                    type: string
                                  name:
                                    default: ""
                                    type: string
                                  optional:
                                    type: boolean
                                required:
                                  - key
                                type: object
                                x-kubernetes-map-type: atomic
                            type: object
                        required:
                          - name
                        type: object
                      type: array
                    jvm:
                      items:
                        type: string
                      type: array
                    rootLoggerLevel:
                      type: string
                  type: object
                defaultStorageClassName:
                  type: string
                disableSeccomp:
                  type: boolean
                image:
                  type: string
                imagePullSecrets:
                  items:
                    properties:
                      name:
                        default: ""
                        type: string
                    type: object
                    x-kubernetes-map-type: atomic
                  type: array
                machineLearningEnabled:
                  type: boolean
                nodes:
                  items:
                    properties:
                      env:
                        items:
                          properties:
                            name:
                              type: string
                            value:
                              type: string
                            valueFrom:
                              properties:
                                configMapKeyRef:
                                  properties:
                                    key:
                                      type: string
                                    name:
                                      default: ""
                                      type: string
                                    optional:
                                      type: boolean
                                  required:
                                    - key
                                  type: object
                                  x-kubernetes-map-type: atomic
                                fieldRef:
                                  properties:
                                    apiVersion:
                                      type: string
                                    fieldPath:
                                      type: string
                                  required:
                                    - fieldPath
                                  type: object
                                  x-kubernetes-map-type: atomic
                                resourceFieldRef:
                                  properties:
                                    containerName:
                                      type: string
                                    divisor:
                                      anyOf:
                                        - type: integer
                                        - type: string
                                      pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                      x-kubernetes-int-or-string: true
                                    resource:
                                      type: string
                                  required:
                                    - resource
                                  type: object
                                  x-kubernetes-map-type: atomic
                                secretKeyRef:
                                  properties:
                                    key:
                                      type: string
                                    name:
                                      default: ""
                                      type: string
                                    optional:
                                      type: boolean
                                  required:
                                    - key
                                  type: object
                                  x-kubernetes-map-type: atomic
                              type: object
                          required:
                            - name
                          type: object
                        type: array
                      heapsize:
                        anyOf:
                          - type: integer
                          - type: string
                        pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                        x-kubernetes-int-or-string: true
                      jvm:
                        items:
                          type: string
                        type: array
                      name:
                        type: string
                      replicas:
                        format: int32
                        minimum: 1
                        type: integer
                      roles:
                        items:
                          enum:
                            - master
                            - data
                            - ingest
                            - ml
                          type: string
                        type: array
                      volume:
                        properties:
                          accessModes:
                            items:
                              type: string
                            type: array
                            x-kubernetes-list-type: atomic
                          dataSource:
                            properties:
                              apiGroup:
                                type: string
                              kind:
                                type: string
                              name:
                                type: string
                            required:
                              - kind
                              - name
                            type: object
                            x-kubernetes-map-type: atomic
                          dataSourceRef:
                            properties:
                              apiGroup:
                                type: string
                              kind:
                                type: string
                              name:
                                type: string
                              namespace:
                                type: string
                            required:
                              - kind
                              - name
                            type: object
                          resources:
                            properties:
                              limits:
                                additionalProperties:
                                  anyOf:
                                    - type: integer
                                    - type: string
                                  pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                  x-kubernetes-int-or-string: true
                                type: object
                              requests:
                                additionalProperties:
                                  anyOf:
                                    - type: integer
                                    - type: string
                                  pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                  x-kubernetes-int-or-string: true
                                type: object
                            type: object
                          selector:
                            properties:
                              matchExpressions:
                                items:
                                  properties:
                                    key:
                                      type: string
                                    operator:
                                      type: string
                                    values:
                                      items:
                                        type: string
                                      type: array
                                      x-kubernetes-list-type: atomic
                                  required:
                                    - key
                                    - operator
                                  type: object
                                type: array
                                x-kubernetes-list-type: atomic
                              matchLabels:
                                additionalProperties:
                                  type: string
                                type: object
                            type: object
                            x-kubernetes-map-type: atomic
                          storageClassName:
                            type: string
                          volumeAttributesClassName:
                            type: string
                          volumeMode:
                            type: string
                          volumeName:
                            type: string
                        type: object
                    required:
                      - name
                    type: object
                  type: array
                security:
                  properties:
                    adminCertFile:
                      type: string
                    cacertsFile:
                      type: string
                    certFile:
                      type: string
                    https:
                      type: boolean
                    insecureSkipVerify:
                      type: boolean
                    keyFile:
                      type: string
                    openIdConnectUrl:
                      type: string
                    selfSignedCertificate:
                      type: boolean
                  type: object
                shutdown:
                  type: boolean
                template:
                  properties:
                    metadata:
                      properties:
                        annotations:
                          additionalProperties:
                            type: string
                          type: object
                        finalizers:
                          items:
                            type: string
                          type: array
                        labels:
                          additionalProperties:
                            type: string
                          type: object
                        name:
                          type: string
                        namespace:
                          type: string
                      type: object
                    spec:
                      properties:
                        activeDeadlineSeconds:
                          format: int64
                          type: integer
                        affinity:
                          properties:
                            nodeAffinity:
                              properties:
                                preferredDuringSchedulingIgnoredDuringExecution:
                                  items:
                                    properties:
                                      preference:
                                        properties:
                                          matchExpressions:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                operator:
                                                  type: string
                                                values:
                                                  items:
                                                    type: string
                                                  type: array
                                                  x-kubernetes-list-type: atomic
                                              required:
                                                - key
                                                - operator
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          matchFields:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                operator:
                                                  type: string
                                                values:
                                                  items:
                                                    type: string
                                                  type: array
                                                  x-kubernetes-list-type: atomic
                                              required:
                                                - key
                                                - operator
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                        type: object
                                        x-kubernetes-map-type: atomic
                                      weight:
                                        format: int32
                                        type: integer
                                    required:
                                      - preference
                                      - weight
                                    type: object
                                  type: array
                                  x-kubernetes-list-type: atomic
                                requiredDuringSchedulingIgnoredDuringExecution:
                                  properties:
                                    nodeSelectorTerms:
                                      items:
                                        properties:
                                          matchExpressions:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                operator:
                                                  type: string
                                                values:
                                                  items:
                                                    type: string
                                                  type: array
                                                  x-kubernetes-list-type: atomic
                                              required:
                                                - key
                                                - operator
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          matchFields:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                operator:
                                                  type: string
                                                values:
                                                  items:
                                                    type: string
                                                  type: array
                                                  x-kubernetes-list-type: atomic
                                              required:
                                                - key
                                                - operator
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                        type: object
                                        x-kubernetes-map-type: atomic
                                      type: array
                                      x-kubernetes-list-type: atomic
                                  required:
                                    - nodeSelectorTerms
                                  type: object
                                  x-kubernetes-map-type: atomic
                              type: object
                            podAffinity:
                              properties:
                                preferredDuringSchedulingIgnoredDuringExecution:
                                  items:
                                    properties:
                                      podAffinityTerm:
                                        properties:
                                          labelSelector:
                                            properties:
                                              matchExpressions:
                                                items:
                                                  properties:
                                                    key:
                                                      type: string
                                                    operator:
                                                      type: string
                                                    values:
                                                      items:
                                                        type: string
                                                      type: array
                                                      x-kubernetes-list-type: atomic
                                                  required:
                                                    - key
                                                    - operator
                                                  type: object
                                                type: array
                                                x-kubernetes-list-type: atomic
                                              matchLabels:
                                                additionalProperties:
                                                  type: string
                                                type: object
                                            type: object
                                            x-kubernetes-map-type: atomic
                                          matchLabelKeys:
                                            items:
                                              type: string
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          mismatchLabelKeys:
                                            items:
                                              type: string
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          namespaceSelector:
                                            properties:
                                              matchExpressions:
                                                items:
                                                  properties:
                                                    key:
                                                      type: string
                                                    operator:
                                                      type: string
                                                    values:
                                                      items:
                                                        type: string
                                                      type: array
                                                      x-kubernetes-list-type: atomic
                                                  required:
                                                    - key
                                                    - operator
                                                  type: object
                                                type: array
                                                x-kubernetes-list-type: atomic
                                              matchLabels:
                                                additionalProperties:
                                                  type: string
                                                type: object
                                            type: object
                                            x-kubernetes-map-type: atomic
                                          namespaces:
                                            items:
                                              type: string
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          topologyKey:
                                            type: string
                                        required:
                                          - topologyKey
                                        type: object
                                      weight:
                                        format: int32
                                        type: integer
                                    required:
                                      - podAffinityTerm
                                      - weight
                                    type: object
                                  type: array
                                  x-kubernetes-list-type: atomic
                                requiredDuringSchedulingIgnoredDuringExecution:
                                  items:
                                    properties:
                                      labelSelector:
                                        properties:
                                          matchExpressions:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                operator:
                                                  type: string
                                                values:
                                                  items:
                                                    type: string
                                                  type: array
                                                  x-kubernetes-list-type: atomic
                                              required:
                                                - key
                                                - operator
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          matchLabels:
                                            additionalProperties:
                                              type: string
                                            type: object
                                        type: object
                                        x-kubernetes-map-type: atomic
                                      matchLabelKeys:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      mismatchLabelKeys:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      namespaceSelector:
                                        properties:
                                          matchExpressions:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                operator:
                                                  type: string
                                                values:
                                                  items:
                                                    type: string
                                                  type: array
                                                  x-kubernetes-list-type: atomic
                                              required:
                                                - key
                                                - operator
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          matchLabels:
                                            additionalProperties:
                                              type: string
                                            type: object
                                        type: object
                                        x-kubernetes-map-type: atomic
                                      namespaces:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      topologyKey:
                                        type: string
                                    required:
                                      - topologyKey
                                    type: object
                                  type: array
                                  x-kubernetes-list-type: atomic
                              type: object
                            podAntiAffinity:
                              properties:
                                preferredDuringSchedulingIgnoredDuringExecution:
                                  items:
                                    properties:
                                      podAffinityTerm:
                                        properties:
                                          labelSelector:
                                            properties:
                                              matchExpressions:
                                                items:
                                                  properties:
                                                    key:
                                                      type: string
                                                    operator:
                                                      type: string
                                                    values:
                                                      items:
                                                        type: string
                                                      type: array
                                                      x-kubernetes-list-type: atomic
                                                  required:
                                                    - key
                                                    - operator
                                                  type: object
                                                type: array
                                                x-kubernetes-list-type: atomic
                                              matchLabels:
                                                additionalProperties:
                                                  type: string
                                                type: object
                                            type: object
                                            x-kubernetes-map-type: atomic
                                          matchLabelKeys:
                                            items:
                                              type: string
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          mismatchLabelKeys:
                                            items:
                                              type: string
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          namespaceSelector:
                                            properties:
                                              matchExpressions:
                                                items:
                                                  properties:
                                                    key:
                                                      type: string
                                                    operator:
                                                      type: string
                                                    values:
                                                      items:
                                                        type: string
                                                      type: array
                                                      x-kubernetes-list-type: atomic
                                                  required:
                                                    - key
                                                    - operator
                                                  type: object
                                                type: array
                                                x-kubernetes-list-type: atomic
                                              matchLabels:
                                                additionalProperties:
                                                  type: string
                                                type: object
                                            type: object
                                            x-kubernetes-map-type: atomic
                                          namespaces:
                                            items:
                                              type: string
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          topologyKey:
                                            type: string
                                        required:
                                          - topologyKey
                                        type: object
                                      weight:
                                        format: int32
                                        type: integer
                                    required:
                                      - podAffinityTerm
                                      - weight
                                    type: object
                                  type: array
                                  x-kubernetes-list-type: atomic
                                requiredDuringSchedulingIgnoredDuringExecution:
                                  items:
                                    properties:
                                      labelSelector:
                                        properties:
                                          matchExpressions:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                operator:
                                                  type: string
                                                values:
                                                  items:
                                                    type: string
                                                  type: array
                                                  x-kubernetes-list-type: atomic
                                              required:
                                                - key
                                                - operator
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          matchLabels:
                                            additionalProperties:
                                              type: string
                                            type: object
                                        type: object
                                        x-kubernetes-map-type: atomic
                                      matchLabelKeys:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      mismatchLabelKeys:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      namespaceSelector:
                                        properties:
                                          matchExpressions:
                                            items:
                                              properties:
                                                key:
                                                  type: string
                                                operator:
                                                  type: string
                                                values:
                                                  items:
                                                    type: string
                                                  type: array
                                                  x-kubernetes-list-type: atomic
                                              required:
                                                - key
                                                - operator
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          matchLabels:
                                            additionalProperties:
                                              type: string
                                            type: object
                                        type: object
                                        x-kubernetes-map-type: atomic
                                      namespaces:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      topologyKey:
                                        type: string
                                    required:
                                      - topologyKey
                                    type: object
                                  type: array
                                  x-kubernetes-list-type: atomic
                              type: object
                          type: object
                        automountServiceAccountToken:
                          type: boolean
                        containers:
                          items:
                            properties:
                              args:
                                items:
                                  type: string
                                type: array
                                x-kubernetes-list-type: atomic
                              command:
                                items:
                                  type: string
                                type: array
                                x-kubernetes-list-type: atomic
                              env:
                                items:
                                  properties:
                                    name:
                                      type: string
                                    value:
                                      type: string
                                    valueFrom:
                                      properties:
                                        configMapKeyRef:
                                          properties:
                                            key:
                                              type: string
                                            name:
                                              default: ""
                                              type: string
                                            optional:
                                              type: boolean
                                          required:
                                            - key
                                          type: object
                                          x-kubernetes-map-type: atomic
                                        fieldRef:
                                          properties:
                                            apiVersion:
                                              type: string
                                            fieldPath:
                                              type: string
                                          required:
                                            - fieldPath
                                          type: object
                                          x-kubernetes-map-type: atomic
                                        resourceFieldRef:
                                          properties:
                                            containerName:
                                              type: string
                                            divisor:
                                              anyOf:
                                                - type: integer
                                                - type: string
                                              pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                              x-kubernetes-int-or-string: true
                                            resource:
                                              type: string
                                          required:
                                            - resource
                                          type: object
                                          x-kubernetes-map-type: atomic
                                        secretKeyRef:
                                          properties:
                                            key:
                                              type: string
                                            name:
                                              default: ""
                                              type: string
                                            optional:
                                              type: boolean
                                          required:
                                            - key
                                          type: object
                                          x-kubernetes-map-type: atomic
                                      type: object
                                  required:
                                    - name
                                  type: object
                                type: array
                                x-kubernetes-list-map-keys:
                                  - name
                                x-kubernetes-list-type: map
                              envFrom:
                                items:
                                  properties:
                                    configMapRef:
                                      properties:
                                        name:
                                          default: ""
                                          type: string
                                        optional:
                                          type: boolean
                                      type: object
                                      x-kubernetes-map-type: atomic
                                    prefix:
                                      type: string
                                    secretRef:
                                      properties:
                                        name:
                                          default: ""
                                          type: string
                                        optional:
                                          type: boolean
                                      type: object
                                      x-kubernetes-map-type: atomic
                                  type: object
                                type: array
                                x-kubernetes-list-type: atomic
                              image:
                                type: string
                              imagePullPolicy:
                                type: string
                              lifecycle:
                                properties:
                                  postStart:
                                    properties:
                                      exec:
                                        properties:
                                          command:
                                            items:
                                              type: string
                                            type: array
                                            x-kubernetes-list-type: atomic
                                        type: object
                                      httpGet:
                                        properties:
                                          host:
                                            type: string
                                          httpHeaders:
                                            items:
                                              properties:
                                                name:
                                                  type: string
                                                value:
                                                  type: string
                                              required:
                                                - name
                                                - value
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          path:
                                            type: string
                                          port:
                                            anyOf:
                                              - type: integer
                                              - type: string
                                            x-kubernetes-int-or-string: true
                                          scheme:
                                            type: string
                                        required:
                                          - port
                                        type: object
                                      sleep:
                                        properties:
                                          seconds:
                                            format: int64
                                            type: integer
                                        required:
                                          - seconds
                                        type: object
                                      tcpSocket:
                                        properties:
                                          host:
                                            type: string
                                          port:
                                            anyOf:
                                              - type: integer
                                              - type: string
                                            x-kubernetes-int-or-string: true
                                        required:
                                          - port
                                        type: object
                                    type: object
                                  preStop:
                                    properties:
                                      exec:
                                        properties:
                                          command:
                                            items:
                                              type: string
                                            type: array
                                            x-kubernetes-list-type: atomic
                                        type: object
                                      httpGet:
                                        properties:
                                          host:
                                            type: string
                                          httpHeaders:
                                            items:
                                              properties:
                                                name:
                                                  type: string
                                                value:
                                                  type: string
                                              required:
                                                - name
                                                - value
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          path:
                                            type: string
                                          port:
                                            anyOf:
                                              - type: integer
                                              - type: string
                                            x-kubernetes-int-or-string: true
                                          scheme:
                                            type: string
                                        required:
                                          - port
                                        type: object
                                      sleep:
                                        properties:
                                          seconds:
                                            format: int64
                                            type: integer
                                        required:
                                          - seconds
                                        type: object
                                      tcpSocket:
                                        properties:
                                          host:
                                            type: string
                                          port:
                                            anyOf:
                                              - type: integer
                                              - type: string
                                            x-kubernetes-int-or-string: true
                                        required:
                                          - port
                                        type: object
                                    type: object
                                type: object
                              livenessProbe:
                                properties:
                                  exec:
                                    properties:
                                      command:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                    type: object
                                  failureThreshold:
                                    format: int32
                                    type: integer
                                  grpc:
                                    properties:
                                      port:
                                        format: int32
                                        type: integer
                                      service:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  httpGet:
                                    properties:
                                      host:
                                        type: string
                                      httpHeaders:
                                        items:
                                          properties:
                                            name:
                                              type: string
                                            value:
                                              type: string
                                          required:
                                            - name
                                            - value
                                          type: object
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      path:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                      scheme:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  initialDelaySeconds:
                                    format: int32
                                    type: integer
                                  periodSeconds:
                                    format: int32
                                    type: integer
                                  successThreshold:
                                    format: int32
                                    type: integer
                                  tcpSocket:
                                    properties:
                                      host:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                    required:
                                      - port
                                    type: object
                                  terminationGracePeriodSeconds:
                                    format: int64
                                    type: integer
                                  timeoutSeconds:
                                    format: int32
                                    type: integer
                                type: object
                              name:
                                type: string
                              ports:
                                items:
                                  properties:
                                    containerPort:
                                      format: int32
                                      type: integer
                                    hostIP:
                                      type: string
                                    hostPort:
                                      format: int32
                                      type: integer
                                    name:
                                      type: string
                                    protocol:
                                      default: TCP
                                      type: string
                                  required:
                                    - containerPort
                                  type: object
                                type: array
                                x-kubernetes-list-map-keys:
                                  - containerPort
                                  - protocol
                                x-kubernetes-list-type: map
                              readinessProbe:
                                properties:
                                  exec:
                                    properties:
                                      command:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                    type: object
                                  failureThreshold:
                                    format: int32
                                    type: integer
                                  grpc:
                                    properties:
                                      port:
                                        format: int32
                                        type: integer
                                      service:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  httpGet:
                                    properties:
                                      host:
                                        type: string
                                      httpHeaders:
                                        items:
                                          properties:
                                            name:
                                              type: string
                                            value:
                                              type: string
                                          required:
                                            - name
                                            - value
                                          type: object
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      path:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                      scheme:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  initialDelaySeconds:
                                    format: int32
                                    type: integer
                                  periodSeconds:
                                    format: int32
                                    type: integer
                                  successThreshold:
                                    format: int32
                                    type: integer
                                  tcpSocket:
                                    properties:
                                      host:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                    required:
                                      - port
                                    type: object
                                  terminationGracePeriodSeconds:
                                    format: int64
                                    type: integer
                                  timeoutSeconds:
                                    format: int32
                                    type: integer
                                type: object
                              resizePolicy:
                                items:
                                  properties:
                                    resourceName:
                                      type: string
                                    restartPolicy:
                                      type: string
                                  required:
                                    - resourceName
                                    - restartPolicy
                                  type: object
                                type: array
                                x-kubernetes-list-type: atomic
                              resources:
                                properties:
                                  claims:
                                    items:
                                      properties:
                                        name:
                                          type: string
                                      required:
                                        - name
                                      type: object
                                    type: array
                                    x-kubernetes-list-map-keys:
                                      - name
                                    x-kubernetes-list-type: map
                                  limits:
                                    additionalProperties:
                                      anyOf:
                                        - type: integer
                                        - type: string
                                      pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                      x-kubernetes-int-or-string: true
                                    type: object
                                  requests:
                                    additionalProperties:
                                      anyOf:
                                        - type: integer
                                        - type: string
                                      pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                      x-kubernetes-int-or-string: true
                                    type: object
                                type: object
                              restartPolicy:
                                type: string
                              securityContext:
                                properties:
                                  allowPrivilegeEscalation:
                                    type: boolean
                                  appArmorProfile:
                                    properties:
                                      localhostProfile:
                                        type: string
                                      type:
                                        type: string
                                    required:
                                      - type
                                    type: object
                                  capabilities:
                                    properties:
                                      add:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      drop:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                    type: object
                                  privileged:
                                    type: boolean
                                  procMount:
                                    type: string
                                  readOnlyRootFilesystem:
                                    type: boolean
                                  runAsGroup:
                                    format: int64
                                    type: integer
                                  runAsNonRoot:
                                    type: boolean
                                  runAsUser:
                                    format: int64
                                    type: integer
                                  seLinuxOptions:
                                    properties:
                                      level:
                                        type: string
                                      role:
                                        type: string
                                      type:
                                        type: string
                                      user:
                                        type: string
                                    type: object
                                  seccompProfile:
                                    properties:
                                      localhostProfile:
                                        type: string
                                      type:
                                        type: string
                                    required:
                                      - type
                                    type: object
                                  windowsOptions:
                                    properties:
                                      gmsaCredentialSpec:
                                        type: string
                                      gmsaCredentialSpecName:
                                        type: string
                                      hostProcess:
                                        type: boolean
                                      runAsUserName:
                                        type: string
                                    type: object
                                type: object
                              startupProbe:
                                properties:
                                  exec:
                                    properties:
                                      command:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                    type: object
                                  failureThreshold:
                                    format: int32
                                    type: integer
                                  grpc:
                                    properties:
                                      port:
                                        format: int32
                                        type: integer
                                      service:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  httpGet:
                                    properties:
                                      host:
                                        type: string
                                      httpHeaders:
                                        items:
                                          properties:
                                            name:
                                              type: string
                                            value:
                                              type: string
                                          required:
                                            - name
                                            - value
                                          type: object
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      path:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                      scheme:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  initialDelaySeconds:
                                    format: int32
                                    type: integer
                                  periodSeconds:
                                    format: int32
                                    type: integer
                                  successThreshold:
                                    format: int32
                                    type: integer
                                  tcpSocket:
                                    properties:
                                      host:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                    required:
                                      - port
                                    type: object
                                  terminationGracePeriodSeconds:
                                    format: int64
                                    type: integer
                                  timeoutSeconds:
                                    format: int32
                                    type: integer
                                type: object
                              stdin:
                                type: boolean
                              stdinOnce:
                                type: boolean
                              terminationMessagePath:
                                type: string
                              terminationMessagePolicy:
                                type: string
                              tty:
                                type: boolean
                              volumeDevices:
                                items:
                                  properties:
                                    devicePath:
                                      type: string
                                    name:
                                      type: string
                                  required:
                                    - devicePath
                                    - name
                                  type: object
                                type: array
                                x-kubernetes-list-map-keys:
                                  - devicePath
                                x-kubernetes-list-type: map
                              volumeMounts:
                                items:
                                  properties:
                                    mountPath:
                                      type: string
                                    mountPropagation:
                                      type: string
                                    name:
                                      type: string
                                    readOnly:
                                      type: boolean
                                    recursiveReadOnly:
                                      type: string
                                    subPath:
                                      type: string
                                    subPathExpr:
                                      type: string
                                  required:
                                    - mountPath
                                    - name
                                  type: object
                                type: array
                                x-kubernetes-list-map-keys:
                                  - mountPath
                                x-kubernetes-list-type: map
                              workingDir:
                                type: string
                            required:
                              - name
                            type: object
                          type: array
                          x-kubernetes-list-map-keys:
                            - name
                          x-kubernetes-list-type: map
                        dnsConfig:
                          properties:
                            nameservers:
                              items:
                                type: string
                              type: array
                              x-kubernetes-list-type: atomic
                            options:
                              items:
                                properties:
                                  name:
                                    type: string
                                  value:
                                    type: string
                                type: object
                              type: array
                              x-kubernetes-list-type: atomic
                            searches:
                              items:
                                type: string
                              type: array
                              x-kubernetes-list-type: atomic
                          type: object
                        dnsPolicy:
                          type: string
                        enableServiceLinks:
                          type: boolean
                        ephemeralContainers:
                          items:
                            properties:
                              args:
                                items:
                                  type: string
                                type: array
                                x-kubernetes-list-type: atomic
                              command:
                                items:
                                  type: string
                                type: array
                                x-kubernetes-list-type: atomic
                              env:
                                items:
                                  properties:
                                    name:
                                      type: string
                                    value:
                                      type: string
                                    valueFrom:
                                      properties:
                                        configMapKeyRef:
                                          properties:
                                            key:
                                              type: string
                                            name:
                                              default: ""
                                              type: string
                                            optional:
                                              type: boolean
                                          required:
                                            - key
                                          type: object
                                          x-kubernetes-map-type: atomic
                                        fieldRef:
                                          properties:
                                            apiVersion:
                                              type: string
                                            fieldPath:
                                              type: string
                                          required:
                                            - fieldPath
                                          type: object
                                          x-kubernetes-map-type: atomic
                                        resourceFieldRef:
                                          properties:
                                            containerName:
                                              type: string
                                            divisor:
                                              anyOf:
                                                - type: integer
                                                - type: string
                                              pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                              x-kubernetes-int-or-string: true
                                            resource:
                                              type: string
                                          required:
                                            - resource
                                          type: object
                                          x-kubernetes-map-type: atomic
                                        secretKeyRef:
                                          properties:
                                            key:
                                              type: string
                                            name:
                                              default: ""
                                              type: string
                                            optional:
                                              type: boolean
                                          required:
                                            - key
                                          type: object
                                          x-kubernetes-map-type: atomic
                                      type: object
                                  required:
                                    - name
                                  type: object
                                type: array
                                x-kubernetes-list-map-keys:
                                  - name
                                x-kubernetes-list-type: map
                              envFrom:
                                items:
                                  properties:
                                    configMapRef:
                                      properties:
                                        name:
                                          default: ""
                                          type: string
                                        optional:
                                          type: boolean
                                      type: object
                                      x-kubernetes-map-type: atomic
                                    prefix:
                                      type: string
                                    secretRef:
                                      properties:
                                        name:
                                          default: ""
                                          type: string
                                        optional:
                                          type: boolean
                                      type: object
                                      x-kubernetes-map-type: atomic
                                  type: object
                                type: array
                                x-kubernetes-list-type: atomic
                              image:
                                type: string
                              imagePullPolicy:
                                type: string
                              lifecycle:
                                properties:
                                  postStart:
                                    properties:
                                      exec:
                                        properties:
                                          command:
                                            items:
                                              type: string
                                            type: array
                                            x-kubernetes-list-type: atomic
                                        type: object
                                      httpGet:
                                        properties:
                                          host:
                                            type: string
                                          httpHeaders:
                                            items:
                                              properties:
                                                name:
                                                  type: string
                                                value:
                                                  type: string
                                              required:
                                                - name
                                                - value
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          path:
                                            type: string
                                          port:
                                            anyOf:
                                              - type: integer
                                              - type: string
                                            x-kubernetes-int-or-string: true
                                          scheme:
                                            type: string
                                        required:
                                          - port
                                        type: object
                                      sleep:
                                        properties:
                                          seconds:
                                            format: int64
                                            type: integer
                                        required:
                                          - seconds
                                        type: object
                                      tcpSocket:
                                        properties:
                                          host:
                                            type: string
                                          port:
                                            anyOf:
                                              - type: integer
                                              - type: string
                                            x-kubernetes-int-or-string: true
                                        required:
                                          - port
                                        type: object
                                    type: object
                                  preStop:
                                    properties:
                                      exec:
                                        properties:
                                          command:
                                            items:
                                              type: string
                                            type: array
                                            x-kubernetes-list-type: atomic
                                        type: object
                                      httpGet:
                                        properties:
                                          host:
                                            type: string
                                          httpHeaders:
                                            items:
                                              properties:
                                                name:
                                                  type: string
                                                value:
                                                  type: string
                                              required:
                                                - name
                                                - value
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          path:
                                            type: string
                                          port:
                                            anyOf:
                                              - type: integer
                                              - type: string
                                            x-kubernetes-int-or-string: true
                                          scheme:
                                            type: string
                                        required:
                                          - port
                                        type: object
                                      sleep:
                                        properties:
                                          seconds:
                                            format: int64
                                            type: integer
                                        required:
                                          - seconds
                                        type: object
                                      tcpSocket:
                                        properties:
                                          host:
                                            type: string
                                          port:
                                            anyOf:
                                              - type: integer
                                              - type: string
                                            x-kubernetes-int-or-string: true
                                        required:
                                          - port
                                        type: object
                                    type: object
                                type: object
                              livenessProbe:
                                properties:
                                  exec:
                                    properties:
                                      command:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                    type: object
                                  failureThreshold:
                                    format: int32
                                    type: integer
                                  grpc:
                                    properties:
                                      port:
                                        format: int32
                                        type: integer
                                      service:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  httpGet:
                                    properties:
                                      host:
                                        type: string
                                      httpHeaders:
                                        items:
                                          properties:
                                            name:
                                              type: string
                                            value:
                                              type: string
                                          required:
                                            - name
                                            - value
                                          type: object
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      path:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                      scheme:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  initialDelaySeconds:
                                    format: int32
                                    type: integer
                                  periodSeconds:
                                    format: int32
                                    type: integer
                                  successThreshold:
                                    format: int32
                                    type: integer
                                  tcpSocket:
                                    properties:
                                      host:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                    required:
                                      - port
                                    type: object
                                  terminationGracePeriodSeconds:
                                    format: int64
                                    type: integer
                                  timeoutSeconds:
                                    format: int32
                                    type: integer
                                type: object
                              name:
                                type: string
                              ports:
                                items:
                                  properties:
                                    containerPort:
                                      format: int32
                                      type: integer
                                    hostIP:
                                      type: string
                                    hostPort:
                                      format: int32
                                      type: integer
                                    name:
                                      type: string
                                    protocol:
                                      default: TCP
                                      type: string
                                  required:
                                    - containerPort
                                  type: object
                                type: array
                                x-kubernetes-list-map-keys:
                                  - containerPort
                                  - protocol
                                x-kubernetes-list-type: map
                              readinessProbe:
                                properties:
                                  exec:
                                    properties:
                                      command:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                    type: object
                                  failureThreshold:
                                    format: int32
                                    type: integer
                                  grpc:
                                    properties:
                                      port:
                                        format: int32
                                        type: integer
                                      service:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  httpGet:
                                    properties:
                                      host:
                                        type: string
                                      httpHeaders:
                                        items:
                                          properties:
                                            name:
                                              type: string
                                            value:
                                              type: string
                                          required:
                                            - name
                                            - value
                                          type: object
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      path:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                      scheme:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  initialDelaySeconds:
                                    format: int32
                                    type: integer
                                  periodSeconds:
                                    format: int32
                                    type: integer
                                  successThreshold:
                                    format: int32
                                    type: integer
                                  tcpSocket:
                                    properties:
                                      host:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                    required:
                                      - port
                                    type: object
                                  terminationGracePeriodSeconds:
                                    format: int64
                                    type: integer
                                  timeoutSeconds:
                                    format: int32
                                    type: integer
                                type: object
                              resizePolicy:
                                items:
                                  properties:
                                    resourceName:
                                      type: string
                                    restartPolicy:
                                      type: string
                                  required:
                                    - resourceName
                                    - restartPolicy
                                  type: object
                                type: array
                                x-kubernetes-list-type: atomic
                              resources:
                                properties:
                                  claims:
                                    items:
                                      properties:
                                        name:
                                          type: string
                                      required:
                                        - name
                                      type: object
                                    type: array
                                    x-kubernetes-list-map-keys:
                                      - name
                                    x-kubernetes-list-type: map
                                  limits:
                                    additionalProperties:
                                      anyOf:
                                        - type: integer
                                        - type: string
                                      pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                      x-kubernetes-int-or-string: true
                                    type: object
                                  requests:
                                    additionalProperties:
                                      anyOf:
                                        - type: integer
                                        - type: string
                                      pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                      x-kubernetes-int-or-string: true
                                    type: object
                                type: object
                              restartPolicy:
                                type: string
                              securityContext:
                                properties:
                                  allowPrivilegeEscalation:
                                    type: boolean
                                  appArmorProfile:
                                    properties:
                                      localhostProfile:
                                        type: string
                                      type:
                                        type: string
                                    required:
                                      - type
                                    type: object
                                  capabilities:
                                    properties:
                                      add:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      drop:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                    type: object
                                  privileged:
                                    type: boolean
                                  procMount:
                                    type: string
                                  readOnlyRootFilesystem:
                                    type: boolean
                                  runAsGroup:
                                    format: int64
                                    type: integer
                                  runAsNonRoot:
                                    type: boolean
                                  runAsUser:
                                    format: int64
                                    type: integer
                                  seLinuxOptions:
                                    properties:
                                      level:
                                        type: string
                                      role:
                                        type: string
                                      type:
                                        type: string
                                      user:
                                        type: string
                                    type: object
                                  seccompProfile:
                                    properties:
                                      localhostProfile:
                                        type: string
                                      type:
                                        type: string
                                    required:
                                      - type
                                    type: object
                                  windowsOptions:
                                    properties:
                                      gmsaCredentialSpec:
                                        type: string
                                      gmsaCredentialSpecName:
                                        type: string
                                      hostProcess:
                                        type: boolean
                                      runAsUserName:
                                        type: string
                                    type: object
                                type: object
                              startupProbe:
                                properties:
                                  exec:
                                    properties:
                                      command:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                    type: object
                                  failureThreshold:
                                    format: int32
                                    type: integer
                                  grpc:
                                    properties:
                                      port:
                                        format: int32
                                        type: integer
                                      service:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  httpGet:
                                    properties:
                                      host:
                                        type: string
                                      httpHeaders:
                                        items:
                                          properties:
                                            name:
                                              type: string
                                            value:
                                              type: string
                                          required:
                                            - name
                                            - value
                                          type: object
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      path:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                      scheme:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  initialDelaySeconds:
                                    format: int32
                                    type: integer
                                  periodSeconds:
                                    format: int32
                                    type: integer
                                  successThreshold:
                                    format: int32
                                    type: integer
                                  tcpSocket:
                                    properties:
                                      host:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                    required:
                                      - port
                                    type: object
                                  terminationGracePeriodSeconds:
                                    format: int64
                                    type: integer
                                  timeoutSeconds:
                                    format: int32
                                    type: integer
                                type: object
                              stdin:
                                type: boolean
                              stdinOnce:
                                type: boolean
                              targetContainerName:
                                type: string
                              terminationMessagePath:
                                type: string
                              terminationMessagePolicy:
                                type: string
                              tty:
                                type: boolean
                              volumeDevices:
                                items:
                                  properties:
                                    devicePath:
                                      type: string
                                    name:
                                      type: string
                                  required:
                                    - devicePath
                                    - name
                                  type: object
                                type: array
                                x-kubernetes-list-map-keys:
                                  - devicePath
                                x-kubernetes-list-type: map
                              volumeMounts:
                                items:
                                  properties:
                                    mountPath:
                                      type: string
                                    mountPropagation:
                                      type: string
                                    name:
                                      type: string
                                    readOnly:
                                      type: boolean
                                    recursiveReadOnly:
                                      type: string
                                    subPath:
                                      type: string
                                    subPathExpr:
                                      type: string
                                  required:
                                    - mountPath
                                    - name
                                  type: object
                                type: array
                                x-kubernetes-list-map-keys:
                                  - mountPath
                                x-kubernetes-list-type: map
                              workingDir:
                                type: string
                            required:
                              - name
                            type: object
                          type: array
                          x-kubernetes-list-map-keys:
                            - name
                          x-kubernetes-list-type: map
                        hostAliases:
                          items:
                            properties:
                              hostnames:
                                items:
                                  type: string
                                type: array
                                x-kubernetes-list-type: atomic
                              ip:
                                type: string
                            required:
                              - ip
                            type: object
                          type: array
                          x-kubernetes-list-map-keys:
                            - ip
                          x-kubernetes-list-type: map
                        hostIPC:
                          type: boolean
                        hostNetwork:
                          type: boolean
                        hostPID:
                          type: boolean
                        hostUsers:
                          type: boolean
                        hostname:
                          type: string
                        imagePullSecrets:
                          items:
                            properties:
                              name:
                                default: ""
                                type: string
                            type: object
                            x-kubernetes-map-type: atomic
                          type: array
                          x-kubernetes-list-map-keys:
                            - name
                          x-kubernetes-list-type: map
                        initContainers:
                          items:
                            properties:
                              args:
                                items:
                                  type: string
                                type: array
                                x-kubernetes-list-type: atomic
                              command:
                                items:
                                  type: string
                                type: array
                                x-kubernetes-list-type: atomic
                              env:
                                items:
                                  properties:
                                    name:
                                      type: string
                                    value:
                                      type: string
                                    valueFrom:
                                      properties:
                                        configMapKeyRef:
                                          properties:
                                            key:
                                              type: string
                                            name:
                                              default: ""
                                              type: string
                                            optional:
                                              type: boolean
                                          required:
                                            - key
                                          type: object
                                          x-kubernetes-map-type: atomic
                                        fieldRef:
                                          properties:
                                            apiVersion:
                                              type: string
                                            fieldPath:
                                              type: string
                                          required:
                                            - fieldPath
                                          type: object
                                          x-kubernetes-map-type: atomic
                                        resourceFieldRef:
                                          properties:
                                            containerName:
                                              type: string
                                            divisor:
                                              anyOf:
                                                - type: integer
                                                - type: string
                                              pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                              x-kubernetes-int-or-string: true
                                            resource:
                                              type: string
                                          required:
                                            - resource
                                          type: object
                                          x-kubernetes-map-type: atomic
                                        secretKeyRef:
                                          properties:
                                            key:
                                              type: string
                                            name:
                                              default: ""
                                              type: string
                                            optional:
                                              type: boolean
                                          required:
                                            - key
                                          type: object
                                          x-kubernetes-map-type: atomic
                                      type: object
                                  required:
                                    - name
                                  type: object
                                type: array
                                x-kubernetes-list-map-keys:
                                  - name
                                x-kubernetes-list-type: map
                              envFrom:
                                items:
                                  properties:
                                    configMapRef:
                                      properties:
                                        name:
                                          default: ""
                                          type: string
                                        optional:
                                          type: boolean
                                      type: object
                                      x-kubernetes-map-type: atomic
                                    prefix:
                                      type: string
                                    secretRef:
                                      properties:
                                        name:
                                          default: ""
                                          type: string
                                        optional:
                                          type: boolean
                                      type: object
                                      x-kubernetes-map-type: atomic
                                  type: object
                                type: array
                                x-kubernetes-list-type: atomic
                              image:
                                type: string
                              imagePullPolicy:
                                type: string
                              lifecycle:
                                properties:
                                  postStart:
                                    properties:
                                      exec:
                                        properties:
                                          command:
                                            items:
                                              type: string
                                            type: array
                                            x-kubernetes-list-type: atomic
                                        type: object
                                      httpGet:
                                        properties:
                                          host:
                                            type: string
                                          httpHeaders:
                                            items:
                                              properties:
                                                name:
                                                  type: string
                                                value:
                                                  type: string
                                              required:
                                                - name
                                                - value
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          path:
                                            type: string
                                          port:
                                            anyOf:
                                              - type: integer
                                              - type: string
                                            x-kubernetes-int-or-string: true
                                          scheme:
                                            type: string
                                        required:
                                          - port
                                        type: object
                                      sleep:
                                        properties:
                                          seconds:
                                            format: int64
                                            type: integer
                                        required:
                                          - seconds
                                        type: object
                                      tcpSocket:
                                        properties:
                                          host:
                                            type: string
                                          port:
                                            anyOf:
                                              - type: integer
                                              - type: string
                                            x-kubernetes-int-or-string: true
                                        required:
                                          - port
                                        type: object
                                    type: object
                                  preStop:
                                    properties:
                                      exec:
                                        properties:
                                          command:
                                            items:
                                              type: string
                                            type: array
                                            x-kubernetes-list-type: atomic
                                        type: object
                                      httpGet:
                                        properties:
                                          host:
                                            type: string
                                          httpHeaders:
                                            items:
                                              properties:
                                                name:
                                                  type: string
                                                value:
                                                  type: string
                                              required:
                                                - name
                                                - value
                                              type: object
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          path:
                                            type: string
                                          port:
                                            anyOf:
                                              - type: integer
                                              - type: string
                                            x-kubernetes-int-or-string: true
                                          scheme:
                                            type: string
                                        required:
                                          - port
                                        type: object
                                      sleep:
                                        properties:
                                          seconds:
                                            format: int64
                                            type: integer
                                        required:
                                          - seconds
                                        type: object
                                      tcpSocket:
                                        properties:
                                          host:
                                            type: string
                                          port:
                                            anyOf:
                                              - type: integer
                                              - type: string
                                            x-kubernetes-int-or-string: true
                                        required:
                                          - port
                                        type: object
                                    type: object
                                type: object
                              livenessProbe:
                                properties:
                                  exec:
                                    properties:
                                      command:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                    type: object
                                  failureThreshold:
                                    format: int32
                                    type: integer
                                  grpc:
                                    properties:
                                      port:
                                        format: int32
                                        type: integer
                                      service:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  httpGet:
                                    properties:
                                      host:
                                        type: string
                                      httpHeaders:
                                        items:
                                          properties:
                                            name:
                                              type: string
                                            value:
                                              type: string
                                          required:
                                            - name
                                            - value
                                          type: object
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      path:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                      scheme:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  initialDelaySeconds:
                                    format: int32
                                    type: integer
                                  periodSeconds:
                                    format: int32
                                    type: integer
                                  successThreshold:
                                    format: int32
                                    type: integer
                                  tcpSocket:
                                    properties:
                                      host:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                    required:
                                      - port
                                    type: object
                                  terminationGracePeriodSeconds:
                                    format: int64
                                    type: integer
                                  timeoutSeconds:
                                    format: int32
                                    type: integer
                                type: object
                              name:
                                type: string
                              ports:
                                items:
                                  properties:
                                    containerPort:
                                      format: int32
                                      type: integer
                                    hostIP:
                                      type: string
                                    hostPort:
                                      format: int32
                                      type: integer
                                    name:
                                      type: string
                                    protocol:
                                      default: TCP
                                      type: string
                                  required:
                                    - containerPort
                                  type: object
                                type: array
                                x-kubernetes-list-map-keys:
                                  - containerPort
                                  - protocol
                                x-kubernetes-list-type: map
                              readinessProbe:
                                properties:
                                  exec:
                                    properties:
                                      command:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                    type: object
                                  failureThreshold:
                                    format: int32
                                    type: integer
                                  grpc:
                                    properties:
                                      port:
                                        format: int32
                                        type: integer
                                      service:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  httpGet:
                                    properties:
                                      host:
                                        type: string
                                      httpHeaders:
                                        items:
                                          properties:
                                            name:
                                              type: string
                                            value:
                                              type: string
                                          required:
                                            - name
                                            - value
                                          type: object
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      path:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                      scheme:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  initialDelaySeconds:
                                    format: int32
                                    type: integer
                                  periodSeconds:
                                    format: int32
                                    type: integer
                                  successThreshold:
                                    format: int32
                                    type: integer
                                  tcpSocket:
                                    properties:
                                      host:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                    required:
                                      - port
                                    type: object
                                  terminationGracePeriodSeconds:
                                    format: int64
                                    type: integer
                                  timeoutSeconds:
                                    format: int32
                                    type: integer
                                type: object
                              resizePolicy:
                                items:
                                  properties:
                                    resourceName:
                                      type: string
                                    restartPolicy:
                                      type: string
                                  required:
                                    - resourceName
                                    - restartPolicy
                                  type: object
                                type: array
                                x-kubernetes-list-type: atomic
                              resources:
                                properties:
                                  claims:
                                    items:
                                      properties:
                                        name:
                                          type: string
                                      required:
                                        - name
                                      type: object
                                    type: array
                                    x-kubernetes-list-map-keys:
                                      - name
                                    x-kubernetes-list-type: map
                                  limits:
                                    additionalProperties:
                                      anyOf:
                                        - type: integer
                                        - type: string
                                      pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                      x-kubernetes-int-or-string: true
                                    type: object
                                  requests:
                                    additionalProperties:
                                      anyOf:
                                        - type: integer
                                        - type: string
                                      pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                      x-kubernetes-int-or-string: true
                                    type: object
                                type: object
                              restartPolicy:
                                type: string
                              securityContext:
                                properties:
                                  allowPrivilegeEscalation:
                                    type: boolean
                                  appArmorProfile:
                                    properties:
                                      localhostProfile:
                                        type: string
                                      type:
                                        type: string
                                    required:
                                      - type
                                    type: object
                                  capabilities:
                                    properties:
                                      add:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      drop:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                    type: object
                                  privileged:
                                    type: boolean
                                  procMount:
                                    type: string
                                  readOnlyRootFilesystem:
                                    type: boolean
                                  runAsGroup:
                                    format: int64
                                    type: integer
                                  runAsNonRoot:
                                    type: boolean
                                  runAsUser:
                                    format: int64
                                    type: integer
                                  seLinuxOptions:
                                    properties:
                                      level:
                                        type: string
                                      role:
                                        type: string
                                      type:
                                        type: string
                                      user:
                                        type: string
                                    type: object
                                  seccompProfile:
                                    properties:
                                      localhostProfile:
                                        type: string
                                      type:
                                        type: string
                                    required:
                                      - type
                                    type: object
                                  windowsOptions:
                                    properties:
                                      gmsaCredentialSpec:
                                        type: string
                                      gmsaCredentialSpecName:
                                        type: string
                                      hostProcess:
                                        type: boolean
                                      runAsUserName:
                                        type: string
                                    type: object
                                type: object
                              startupProbe:
                                properties:
                                  exec:
                                    properties:
                                      command:
                                        items:
                                          type: string
                                        type: array
                                        x-kubernetes-list-type: atomic
                                    type: object
                                  failureThreshold:
                                    format: int32
                                    type: integer
                                  grpc:
                                    properties:
                                      port:
                                        format: int32
                                        type: integer
                                      service:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  httpGet:
                                    properties:
                                      host:
                                        type: string
                                      httpHeaders:
                                        items:
                                          properties:
                                            name:
                                              type: string
                                            value:
                                              type: string
                                          required:
                                            - name
                                            - value
                                          type: object
                                        type: array
                                        x-kubernetes-list-type: atomic
                                      path:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                      scheme:
                                        type: string
                                    required:
                                      - port
                                    type: object
                                  initialDelaySeconds:
                                    format: int32
                                    type: integer
                                  periodSeconds:
                                    format: int32
                                    type: integer
                                  successThreshold:
                                    format: int32
                                    type: integer
                                  tcpSocket:
                                    properties:
                                      host:
                                        type: string
                                      port:
                                        anyOf:
                                          - type: integer
                                          - type: string
                                        x-kubernetes-int-or-string: true
                                    required:
                                      - port
                                    type: object
                                  terminationGracePeriodSeconds:
                                    format: int64
                                    type: integer
                                  timeoutSeconds:
                                    format: int32
                                    type: integer
                                type: object
                              stdin:
                                type: boolean
                              stdinOnce:
                                type: boolean
                              terminationMessagePath:
                                type: string
                              terminationMessagePolicy:
                                type: string
                              tty:
                                type: boolean
                              volumeDevices:
                                items:
                                  properties:
                                    devicePath:
                                      type: string
                                    name:
                                      type: string
                                  required:
                                    - devicePath
                                    - name
                                  type: object
                                type: array
                                x-kubernetes-list-map-keys:
                                  - devicePath
                                x-kubernetes-list-type: map
                              volumeMounts:
                                items:
                                  properties:
                                    mountPath:
                                      type: string
                                    mountPropagation:
                                      type: string
                                    name:
                                      type: string
                                    readOnly:
                                      type: boolean
                                    recursiveReadOnly:
                                      type: string
                                    subPath:
                                      type: string
                                    subPathExpr:
                                      type: string
                                  required:
                                    - mountPath
                                    - name
                                  type: object
                                type: array
                                x-kubernetes-list-map-keys:
                                  - mountPath
                                x-kubernetes-list-type: map
                              workingDir:
                                type: string
                            required:
                              - name
                            type: object
                          type: array
                          x-kubernetes-list-map-keys:
                            - name
                          x-kubernetes-list-type: map
                        nodeName:
                          type: string
                        nodeSelector:
                          additionalProperties:
                            type: string
                          type: object
                          x-kubernetes-map-type: atomic
                        os:
                          properties:
                            name:
                              type: string
                          required:
                            - name
                          type: object
                        overhead:
                          additionalProperties:
                            anyOf:
                              - type: integer
                              - type: string
                            pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                            x-kubernetes-int-or-string: true
                          type: object
                        preemptionPolicy:
                          type: string
                        priority:
                          format: int32
                          type: integer
                        priorityClassName:
                          type: string
                        readinessGates:
                          items:
                            properties:
                              conditionType:
                                type: string
                            required:
                              - conditionType
                            type: object
                          type: array
                          x-kubernetes-list-type: atomic
                        resourceClaims:
                          items:
                            properties:
                              name:
                                type: string
                              source:
                                properties:
                                  resourceClaimName:
                                    type: string
                                  resourceClaimTemplateName:
                                    type: string
                                type: object
                            required:
                              - name
                            type: object
                          type: array
                          x-kubernetes-list-map-keys:
                            - name
                          x-kubernetes-list-type: map
                        restartPolicy:
                          type: string
                        runtimeClassName:
                          type: string
                        schedulerName:
                          type: string
                        schedulingGates:
                          items:
                            properties:
                              name:
                                type: string
                            required:
                              - name
                            type: object
                          type: array
                          x-kubernetes-list-map-keys:
                            - name
                          x-kubernetes-list-type: map
                        securityContext:
                          properties:
                            appArmorProfile:
                              properties:
                                localhostProfile:
                                  type: string
                                type:
                                  type: string
                              required:
                                - type
                              type: object
                            fsGroup:
                              format: int64
                              type: integer
                            fsGroupChangePolicy:
                              type: string
                            runAsGroup:
                              format: int64
                              type: integer
                            runAsNonRoot:
                              type: boolean
                            runAsUser:
                              format: int64
                              type: integer
                            seLinuxOptions:
                              properties:
                                level:
                                  type: string
                                role:
                                  type: string
                                type:
                                  type: string
                                user:
                                  type: string
                              type: object
                            seccompProfile:
                              properties:
                                localhostProfile:
                                  type: string
                                type:
                                  type: string
                              required:
                                - type
                              type: object
                            supplementalGroups:
                              items:
                                format: int64
                                type: integer
                              type: array
                              x-kubernetes-list-type: atomic
                            sysctls:
                              items:
                                properties:
                                  name:
                                    type: string
                                  value:
                                    type: string
                                required:
                                  - name
                                  - value
                                type: object
                              type: array
                              x-kubernetes-list-type: atomic
                            windowsOptions:
                              properties:
                                gmsaCredentialSpec:
                                  type: string
                                gmsaCredentialSpecName:
                                  type: string
                                hostProcess:
                                  type: boolean
                                runAsUserName:
                                  type: string
                              type: object
                          type: object
                        serviceAccount:
                          type: string
                        serviceAccountName:
                          type: string
                        setHostnameAsFQDN:
                          type: boolean
                        shareProcessNamespace:
                          type: boolean
                        subdomain:
                          type: string
                        terminationGracePeriodSeconds:
                          format: int64
                          type: integer
                        tolerations:
                          items:
                            properties:
                              effect:
                                type: string
                              key:
                                type: string
                              operator:
                                type: string
                              tolerationSeconds:
                                format: int64
                                type: integer
                              value:
                                type: string
                            type: object
                          type: array
                          x-kubernetes-list-type: atomic
                        topologySpreadConstraints:
                          items:
                            properties:
                              labelSelector:
                                properties:
                                  matchExpressions:
                                    items:
                                      properties:
                                        key:
                                          type: string
                                        operator:
                                          type: string
                                        values:
                                          items:
                                            type: string
                                          type: array
                                          x-kubernetes-list-type: atomic
                                      required:
                                        - key
                                        - operator
                                      type: object
                                    type: array
                                    x-kubernetes-list-type: atomic
                                  matchLabels:
                                    additionalProperties:
                                      type: string
                                    type: object
                                type: object
                                x-kubernetes-map-type: atomic
                              matchLabelKeys:
                                items:
                                  type: string
                                type: array
                                x-kubernetes-list-type: atomic
                              maxSkew:
                                format: int32
                                type: integer
                              minDomains:
                                format: int32
                                type: integer
                              nodeAffinityPolicy:
                                type: string
                              nodeTaintsPolicy:
                                type: string
                              topologyKey:
                                type: string
                              whenUnsatisfiable:
                                type: string
                            required:
                              - maxSkew
                              - topologyKey
                              - whenUnsatisfiable
                            type: object
                          type: array
                          x-kubernetes-list-map-keys:
                            - topologyKey
                            - whenUnsatisfiable
                          x-kubernetes-list-type: map
                        volumes:
                          items:
                            properties:
                              awsElasticBlockStore:
                                properties:
                                  fsType:
                                    type: string
                                  partition:
                                    format: int32
                                    type: integer
                                  readOnly:
                                    type: boolean
                                  volumeID:
                                    type: string
                                required:
                                  - volumeID
                                type: object
                              azureDisk:
                                properties:
                                  cachingMode:
                                    type: string
                                  diskName:
                                    type: string
                                  diskURI:
                                    type: string
                                  fsType:
                                    type: string
                                  kind:
                                    type: string
                                  readOnly:
                                    type: boolean
                                required:
                                  - diskName
                                  - diskURI
                                type: object
                              azureFile:
                                properties:
                                  readOnly:
                                    type: boolean
                                  secretName:
                                    type: string
                                  shareName:
                                    type: string
                                required:
                                  - secretName
                                  - shareName
                                type: object
                              cephfs:
                                properties:
                                  monitors:
                                    items:
                                      type: string
                                    type: array
                                    x-kubernetes-list-type: atomic
                                  path:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  secretFile:
                                    type: string
                                  secretRef:
                                    properties:
                                      name:
                                        default: ""
                                        type: string
                                    type: object
                                    x-kubernetes-map-type: atomic
                                  user:
                                    type: string
                                required:
                                  - monitors
                                type: object
                              cinder:
                                properties:
                                  fsType:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  secretRef:
                                    properties:
                                      name:
                                        default: ""
                                        type: string
                                    type: object
                                    x-kubernetes-map-type: atomic
                                  volumeID:
                                    type: string
                                required:
                                  - volumeID
                                type: object
                              configMap:
                                properties:
                                  defaultMode:
                                    format: int32
                                    type: integer
                                  items:
                                    items:
                                      properties:
                                        key:
                                          type: string
                                        mode:
                                          format: int32
                                          type: integer
                                        path:
                                          type: string
                                      required:
                                        - key
                                        - path
                                      type: object
                                    type: array
                                    x-kubernetes-list-type: atomic
                                  name:
                                    default: ""
                                    type: string
                                  optional:
                                    type: boolean
                                type: object
                                x-kubernetes-map-type: atomic
                              csi:
                                properties:
                                  driver:
                                    type: string
                                  fsType:
                                    type: string
                                  nodePublishSecretRef:
                                    properties:
                                      name:
                                        default: ""
                                        type: string
                                    type: object
                                    x-kubernetes-map-type: atomic
                                  readOnly:
                                    type: boolean
                                  volumeAttributes:
                                    additionalProperties:
                                      type: string
                                    type: object
                                required:
                                  - driver
                                type: object
                              downwardAPI:
                                properties:
                                  defaultMode:
                                    format: int32
                                    type: integer
                                  items:
                                    items:
                                      properties:
                                        fieldRef:
                                          properties:
                                            apiVersion:
                                              type: string
                                            fieldPath:
                                              type: string
                                          required:
                                            - fieldPath
                                          type: object
                                          x-kubernetes-map-type: atomic
                                        mode:
                                          format: int32
                                          type: integer
                                        path:
                                          type: string
                                        resourceFieldRef:
                                          properties:
                                            containerName:
                                              type: string
                                            divisor:
                                              anyOf:
                                                - type: integer
                                                - type: string
                                              pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                              x-kubernetes-int-or-string: true
                                            resource:
                                              type: string
                                          required:
                                            - resource
                                          type: object
                                          x-kubernetes-map-type: atomic
                                      required:
                                        - path
                                      type: object
                                    type: array
                                    x-kubernetes-list-type: atomic
                                type: object
                              emptyDir:
                                properties:
                                  medium:
                                    type: string
                                  sizeLimit:
                                    anyOf:
                                      - type: integer
                                      - type: string
                                    pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                    x-kubernetes-int-or-string: true
                                type: object
                              ephemeral:
                                properties:
                                  volumeClaimTemplate:
                                    properties:
                                      metadata:
                                        properties:
                                          annotations:
                                            additionalProperties:
                                              type: string
                                            type: object
                                          finalizers:
                                            items:
                                              type: string
                                            type: array
                                          labels:
                                            additionalProperties:
                                              type: string
                                            type: object
                                          name:
                                            type: string
                                          namespace:
                                            type: string
                                        type: object
                                      spec:
                                        properties:
                                          accessModes:
                                            items:
                                              type: string
                                            type: array
                                            x-kubernetes-list-type: atomic
                                          dataSource:
                                            properties:
                                              apiGroup:
                                                type: string
                                              kind:
                                                type: string
                                              name:
                                                type: string
                                            required:
                                              - kind
                                              - name
                                            type: object
                                            x-kubernetes-map-type: atomic
                                          dataSourceRef:
                                            properties:
                                              apiGroup:
                                                type: string
                                              kind:
                                                type: string
                                              name:
                                                type: string
                                              namespace:
                                                type: string
                                            required:
                                              - kind
                                              - name
                                            type: object
                                          resources:
                                            properties:
                                              limits:
                                                additionalProperties:
                                                  anyOf:
                                                    - type: integer
                                                    - type: string
                                                  pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                                  x-kubernetes-int-or-string: true
                                                type: object
                                              requests:
                                                additionalProperties:
                                                  anyOf:
                                                    - type: integer
                                                    - type: string
                                                  pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                                  x-kubernetes-int-or-string: true
                                                type: object
                                            type: object
                                          selector:
                                            properties:
                                              matchExpressions:
                                                items:
                                                  properties:
                                                    key:
                                                      type: string
                                                    operator:
                                                      type: string
                                                    values:
                                                      items:
                                                        type: string
                                                      type: array
                                                      x-kubernetes-list-type: atomic
                                                  required:
                                                    - key
                                                    - operator
                                                  type: object
                                                type: array
                                                x-kubernetes-list-type: atomic
                                              matchLabels:
                                                additionalProperties:
                                                  type: string
                                                type: object
                                            type: object
                                            x-kubernetes-map-type: atomic
                                          storageClassName:
                                            type: string
                                          volumeAttributesClassName:
                                            type: string
                                          volumeMode:
                                            type: string
                                          volumeName:
                                            type: string
                                        type: object
                                    required:
                                      - spec
                                    type: object
                                type: object
                              fc:
                                properties:
                                  fsType:
                                    type: string
                                  lun:
                                    format: int32
                                    type: integer
                                  readOnly:
                                    type: boolean
                                  targetWWNs:
                                    items:
                                      type: string
                                    type: array
                                    x-kubernetes-list-type: atomic
                                  wwids:
                                    items:
                                      type: string
                                    type: array
                                    x-kubernetes-list-type: atomic
                                type: object
                              flexVolume:
                                properties:
                                  driver:
                                    type: string
                                  fsType:
                                    type: string
                                  options:
                                    additionalProperties:
                                      type: string
                                    type: object
                                  readOnly:
                                    type: boolean
                                  secretRef:
                                    properties:
                                      name:
                                        default: ""
                                        type: string
                                    type: object
                                    x-kubernetes-map-type: atomic
                                required:
                                  - driver
                                type: object
                              flocker:
                                properties:
                                  datasetName:
                                    type: string
                                  datasetUUID:
                                    type: string
                                type: object
                              gcePersistentDisk:
                                properties:
                                  fsType:
                                    type: string
                                  partition:
                                    format: int32
                                    type: integer
                                  pdName:
                                    type: string
                                  readOnly:
                                    type: boolean
                                required:
                                  - pdName
                                type: object
                              gitRepo:
                                properties:
                                  directory:
                                    type: string
                                  repository:
                                    type: string
                                  revision:
                                    type: string
                                required:
                                  - repository
                                type: object
                              glusterfs:
                                properties:
                                  endpoints:
                                    type: string
                                  path:
                                    type: string
                                  readOnly:
                                    type: boolean
                                required:
                                  - endpoints
                                  - path
                                type: object
                              hostPath:
                                properties:
                                  path:
                                    type: string
                                  type:
                                    type: string
                                required:
                                  - path
                                type: object
                              iscsi:
                                properties:
                                  chapAuthDiscovery:
                                    type: boolean
                                  chapAuthSession:
                                    type: boolean
                                  fsType:
                                    type: string
                                  initiatorName:
                                    type: string
                                  iqn:
                                    type: string
                                  iscsiInterface:
                                    type: string
                                  lun:
                                    format: int32
                                    type: integer
                                  portals:
                                    items:
                                      type: string
                                    type: array
                                    x-kubernetes-list-type: atomic
                                  readOnly:
                                    type: boolean
                                  secretRef:
                                    properties:
                                      name:
                                        default: ""
                                        type: string
                                    type: object
                                    x-kubernetes-map-type: atomic
                                  targetPortal:
                                    type: string
                                required:
                                  - iqn
                                  - lun
                                  - targetPortal
                                type: object
                              name:
                                type: string
                              nfs:
                                properties:
                                  path:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  server:
                                    type: string
                                required:
                                  - path
                                  - server
                                type: object
                              persistentVolumeClaim:
                                properties:
                                  claimName:
                                    type: string
                                  readOnly:
                                    type: boolean
                                required:
                                  - claimName
                                type: object
                              photonPersistentDisk:
                                properties:
                                  fsType:
                                    type: string
                                  pdID:
                                    type: string
                                required:
                                  - pdID
                                type: object
                              portworxVolume:
                                properties:
                                  fsType:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  volumeID:
                                    type: string
                                required:
                                  - volumeID
                                type: object
                              projected:
                                properties:
                                  defaultMode:
                                    format: int32
                                    type: integer
                                  sources:
                                    items:
                                      properties:
                                        clusterTrustBundle:
                                          properties:
                                            labelSelector:
                                              properties:
                                                matchExpressions:
                                                  items:
                                                    properties:
                                                      key:
                                                        type: string
                                                      operator:
                                                        type: string
                                                      values:
                                                        items:
                                                          type: string
                                                        type: array
                                                        x-kubernetes-list-type: atomic
                                                    required:
                                                      - key
                                                      - operator
                                                    type: object
                                                  type: array
                                                  x-kubernetes-list-type: atomic
                                                matchLabels:
                                                  additionalProperties:
                                                    type: string
                                                  type: object
                                              type: object
                                              x-kubernetes-map-type: atomic
                                            name:
                                              type: string
                                            optional:
                                              type: boolean
                                            path:
                                              type: string
                                            signerName:
                                              type: string
                                          required:
                                            - path
                                          type: object
                                        configMap:
                                          properties:
                                            items:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  mode:
                                                    format: int32
                                                    type: integer
                                                  path:
                                                    type: string
                                                required:
                                                  - key
                                                  - path
                                                type: object
                                              type: array
                                              x-kubernetes-list-type: atomic
                                            name:
                                              default: ""
                                              type: string
                                            optional:
                                              type: boolean
                                          type: object
                                          x-kubernetes-map-type: atomic
                                        downwardAPI:
                                          properties:
                                            items:
                                              items:
                                                properties:
                                                  fieldRef:
                                                    properties:
                                                      apiVersion:
                                                        type: string
                                                      fieldPath:
                                                        type: string
                                                    required:
                                                      - fieldPath
                                                    type: object
                                                    x-kubernetes-map-type: atomic
                                                  mode:
                                                    format: int32
                                                    type: integer
                                                  path:
                                                    type: string
                                                  resourceFieldRef:
                                                    properties:
                                                      containerName:
                                                        type: string
                                                      divisor:
                                                        anyOf:
                                                          - type: integer
                                                          - type: string
                                                        pattern: ^(\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\+|-)?(([0-9]+(\.[0-9]*)?)|(\.[0-9]+))))?$
                                                        x-kubernetes-int-or-string: true
                                                      resource:
                                                        type: string
                                                    required:
                                                      - resource
                                                    type: object
                                                    x-kubernetes-map-type: atomic
                                                required:
                                                  - path
                                                type: object
                                              type: array
                                              x-kubernetes-list-type: atomic
                                          type: object
                                        secret:
                                          properties:
                                            items:
                                              items:
                                                properties:
                                                  key:
                                                    type: string
                                                  mode:
                                                    format: int32
                                                    type: integer
                                                  path:
                                                    type: string
                                                required:
                                                  - key
                                                  - path
                                                type: object
                                              type: array
                                              x-kubernetes-list-type: atomic
                                            name:
                                              default: ""
                                              type: string
                                            optional:
                                              type: boolean
                                          type: object
                                          x-kubernetes-map-type: atomic
                                        serviceAccountToken:
                                          properties:
                                            audience:
                                              type: string
                                            expirationSeconds:
                                              format: int64
                                              type: integer
                                            path:
                                              type: string
                                          required:
                                            - path
                                          type: object
                                      type: object
                                    type: array
                                    x-kubernetes-list-type: atomic
                                type: object
                              quobyte:
                                properties:
                                  group:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  registry:
                                    type: string
                                  tenant:
                                    type: string
                                  user:
                                    type: string
                                  volume:
                                    type: string
                                required:
                                  - registry
                                  - volume
                                type: object
                              rbd:
                                properties:
                                  fsType:
                                    type: string
                                  image:
                                    type: string
                                  keyring:
                                    type: string
                                  monitors:
                                    items:
                                      type: string
                                    type: array
                                    x-kubernetes-list-type: atomic
                                  pool:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  secretRef:
                                    properties:
                                      name:
                                        default: ""
                                        type: string
                                    type: object
                                    x-kubernetes-map-type: atomic
                                  user:
                                    type: string
                                required:
                                  - image
                                  - monitors
                                type: object
                              scaleIO:
                                properties:
                                  fsType:
                                    type: string
                                  gateway:
                                    type: string
                                  protectionDomain:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  secretRef:
                                    properties:
                                      name:
                                        default: ""
                                        type: string
                                    type: object
                                    x-kubernetes-map-type: atomic
                                  sslEnabled:
                                    type: boolean
                                  storageMode:
                                    type: string
                                  storagePool:
                                    type: string
                                  system:
                                    type: string
                                  volumeName:
                                    type: string
                                required:
                                  - gateway
                                  - secretRef
                                  - system
                                type: object
                              secret:
                                properties:
                                  defaultMode:
                                    format: int32
                                    type: integer
                                  items:
                                    items:
                                      properties:
                                        key:
                                          type: string
                                        mode:
                                          format: int32
                                          type: integer
                                        path:
                                          type: string
                                      required:
                                        - key
                                        - path
                                      type: object
                                    type: array
                                    x-kubernetes-list-type: atomic
                                  optional:
                                    type: boolean
                                  secretName:
                                    type: string
                                type: object
                              storageos:
                                properties:
                                  fsType:
                                    type: string
                                  readOnly:
                                    type: boolean
                                  secretRef:
                                    properties:
                                      name:
                                        default: ""
                                        type: string
                                    type: object
                                    x-kubernetes-map-type: atomic
                                  volumeName:
                                    type: string
                                  volumeNamespace:
                                    type: string
                                type: object
                              vsphereVolume:
                                properties:
                                  fsType:
                                    type: string
                                  storagePolicyID:
                                    type: string
                                  storagePolicyName:
                                    type: string
                                  volumePath:
                                    type: string
                                required:
                                  - volumePath
                                type: object
                            required:
                              - name
                            type: object
                          type: array
                          x-kubernetes-list-map-keys:
                            - name
                          x-kubernetes-list-type: map
                      required:
                        - containers
                      type: object
                  type: object
                testMode:
                  type: boolean
                upgradeTimeout:
                  type: integer
              required:
                - nodes
              type: object
            status:
              properties:
                auditLogRetentionApplied:
                  type: boolean
                conditionHistory:
                  items:
                    properties:
                      lastTransitionTime:
                        format: date-time
                        type: string
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
                conditions:
                  items:
                    properties:
                      lastTransitionTime:
                        format: date-time
                        type: string
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
                configuration:
                  properties:
                    auditConfig:
                      type: string
                    config:
                      type: string
                    image:
                      type: string
                    imagePullSecrets:
                      items:
                        properties:
                          name:
                            default: ""
                            type: string
                        type: object
                        x-kubernetes-map-type: atomic
                      type: array
                    security:
                      type: string
                    template:
                      type: string
                  required:
                    - image
                  type: object
                discoveryService:
                  properties:
                    name:
                      type: string
                    ref:
                      properties:
                        apiGroup:
                          type: string
                        kind:
                          type: string
                        name:
                          type: string
                      required:
                        - kind
                        - name
                      type: object
                      x-kubernetes-map-type: atomic
                  required:
                    - name
                    - ref
                  type: object
                nodes:
                  properties:
                    masterEligible:
                      items:
                        properties:
                          name:
                            type: string
                        required:
                          - name
                        type: object
                      type: array
                    other:
                      items:
                        properties:
                          name:
                            type: string
                        required:
                          - name
                        type: object
                      type: array
                  required:
                    - masterEligible
                    - other
                  type: object
                service:
                  properties:
                    name:
                      type: string
                    ref:
                      properties:
                        apiGroup:
                          type: string
                        kind:
                          type: string
                        name:
                          type: string
                      required:
                        - kind
                        - name
                      type: object
                      x-kubernetes-map-type: atomic
                  required:
                    - name
                    - ref
                  type: object
                suspended:
                  type: boolean
                upgrading:
                  items:
                    type: string
                  type: array
              type: object
          type: object
      served: true
      storage: true
      subresources:
        scale:
          labelSelectorPath: .status.selector
          specReplicasPath: .spec.nodes[0].replicas
          statusReplicasPath: .status.replicas
        status: {}
