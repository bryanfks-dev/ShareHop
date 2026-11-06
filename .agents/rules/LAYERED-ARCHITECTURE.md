# Layered Architecture Rules

This projects follows the clean architecture principles, with a layered architecture design. The main layers are:

1. **Controller**: Handles incoming requests and returns responses.
2. **Use Case (Business Rules)**: Contains the business logic of the application.
3. **Repository or Service**: Provides data access and external API calls.

## Layers

Controller -> Use Case (Business Rules) -> Service (Optional) -> Repository or Gateways.

## Controller

- Controller layer is the entry point of the application.
- Controller layer is the only layer that can call use case layer.
- Controller layer placed in `lib/presentation/controllers` directory.
- Controller layer should be named after the aggregate root model name that the controller is acting on, and the action that the controller is performing.
  - Good: `UserController`, `PaymentController`, `FileTransferController`
  - Bad: `CreateUserController`, `GetPaymentController`, `TransferFileController`

## Use Case

- Use Case layer contains the business rules of the application.
- Use Case layer is the only layer that contains business logic.
- Use Case layer is the only layer that can call service layer for shared business logic that can be reused across multiple use cases.
- Use Case layer is the only layer that can call repository or gateway layer.
- Use Case layer placed in `lib/core/use_cases` directory.
- Use Case class should always have a single public method named `call` that contains the main business logic of the use case.

### Use Case Naming Convention

- Use Case class MUST have a name ending with `UseCase`.
  - Good: `CreateUserUseCase`, `GetPaymentUseCase`, `TransferFileUseCase`
  - Bad: `CreateUser`, `GetPayment`, `TransferFile`
- Use Case class named after the action that the use case is peforming, and the aggregate root model name that the use case is acting on.
  - Good: `CreateUserUseCase`, `GetPaymentUseCase`, `TransferFileUseCase`
  - Bad: `UserUseCase`, `PaymentUseCase`, `FileTransferUseCase`
- Use Case file and class name SHOULD be matched.

## Service

- Service layer is an OPTIONAL layer that contains shared business logic that can be reused across multiple use cases.
- Service layer is the only layer that can call gateway layer.
- Service layer placed in `lib/core/services` directory.
- Service layer's methods should be named after the action that the service is performing, and the model name that the service is acting on.
  - Good: `createUser`, `getPayment`, `transferFile`
  - Bad: `user`, `payment`, `fileTransfer`
- Service layer should be named after the action that the service is performing, and the aggregate root model name that the service is acting on.
  - Good: `UserService`, `PaymentService`, `FileTransferService`
  - Bad: `CreateUserService`, `GetPaymentService`, `TransferFileService`
- Service layer should be used for shared business logic that can be reused across multiple use cases, such as sending emails, generating reports, or processing payments.

### Service Naming Convention

- Service class MUST have a name ending with `Service`.
  - Good: `UserService`, `PaymentService`, `FileTransferService`
  - Bad: `CreateUserService`, `GetPaymentService`, `TransferFileService`
- Service class named after the action that the service is peforming, and the aggregate root model name that the service is acting on.
  - Good: `UserService`, `PaymentService`, `FileTransferService`
  - Bad: `CreateUserService`, `GetPaymentService`, `TransferFileService`
- Service file and class name SHOULD be matched.

## Repository

- Port of repository layer live in `lib/core/repositories`.
- Adapter of repository layer live in `lib/infrastructures/repositories`.
- ALL data source access (DB queriess, ORM calls, cache read) lives here and ONLY here.
- Repositories NOT contains any business logic.
- If the exposed repository method's parameters exceed count of `3`, create a DTO class that contains the function parameters inside the port repository layer directory.

### Repository Naming Convention

- Port of repository class MUST have a name ending with `Repository`.
  - Good: `UserRepository`, `PaymentRepository`, `FileTransferRepository`
  - Bad: `User`, `Payment`, `FileTransfer`
- Repository class should be placed inside a directory named after the aggregate root model name like `user`, `payment`, `file_transfer`.
- Adapter of repository layer MUST have suffix `Impl` as the mark of implementation of port repository.
  - Good: `UserRepositoryImpl`, `PaymentRepositoryImpl`, `FileTransferRepositoryImpl`
  - Bad: `UserRepository`, `PaymentRepository`, `FileTransferRepository`
- Repository exposed methods name should be named after the action that the repository is performing, and the model name that the repository is acting on.
  - Good: `findUserById`, `findPaymentById`, `findFileTransferById`
  - Bad: `user`, `payment`, `fileTransfer`
- Use case must fetch/persist data through repository layer, never directly access the data source (DB, cache, etc) from use case layer.

## Repository Layer Naming Convention

- Repository class MUST have a name ending with `Repository`.
  - Good: `UserRepository`, `PaymentRepository`, `FileTransferRepository`
  - Bad: `User`, `Payment`, `FileTransfer`
- Repository class should be placed inside a directory named after the aggregate root model name like `user`, `payment`, `file_transfer`.
- Adapter of repository layer always has a suffix `Impl` as the mark of implementation of port repository.
  - Good: `UserRepositoryImpl`, `PaymentRepositoryImpl`, `FileTransferRepositoryImpl`
  - Bad: `UserRepository`, `PaymentRepository`, `FileTransferRepository`
- Repository exposed methods name should be named after the action that the repository is performing, and the model name that the repository is acting on.
  - Good: `findUserById`, `findPaymentById`, `findFileTransferById`
  - Bad: `user`, `payment`, `fileTransfer`

## Gateway

- Port of gateway layer live in `lib/core/gateways`.
- Adapter of gateway layer live in `lib/infrastructures/gateways`.
- ALL external API calls (HTTP clients, third-party SDKs, webhooks) live here and ONLY here.
- Gateway NOT contains any business logic.
- Wrap external response in typed DTOs; never leak raw third-party payloads to the upper layer (use case, controller).
- Handle timeouts, retries, and error handling here.
- If the exposed gateway method's parameters exceed count of `3`, create a DTO class that contains the function parameters inside the port gateway layer directory.
- Use Case must call external API through gateway layer, never directly access the external API from use case layer.

### Gateway Naming Convention

- Port of gateway class MUST have a name ending with `Gateway`.
  - Good: `UserGateway`, `PaymentGateway`, `FileTransferGateway`
  - Bad: `User`, `Payment`, `FileTransfer`
- Gateway class should be placed inside a directory named after the aggregate root model name like `user`, `payment`, `file_transfer`.
- Adapter of gateway layer MUST have a suffix `Impl` as the mark of implementation of port gateway.
  - Good: `UserGatewayImpl`, `PaymentGatewayImpl`, `FileTransferGatewayImpl`
  - Bad: `UserGateway`, `PaymentGateway`, `FileTransferGateway`
- Gateway exposed methods name should be named after the action that the gateway is performing, and the model name that the gateway is acting on.
  - Good: `createUser`, `getPayment`, `transferFile`
  - Bad: `user`, `payment`, `fileTransfer`

## Data Transfer Object (DTO)

- DTO only used for transferring data between layers, especially when the function parameters exceed count of `3`.
- Every DTO class MUST placed inside `dto` file in each needed folder, regarding the scope of the DTO (global level, service level, repository level)
- Global DTO class can be placed in `lib/core/data/dto` directory with creating a new file named after the domain of that DTO class.

### DTO Naming Convention

- Every DTO class MUST have a name ending with `Dto`.
  - Good: `CreateUserDto`, `PaymentResponseDto`, `GithubUserDto`
  - Bad: `CreateUser`, `PaymentResponse`, `UserDTO`, `UserData`
- Do not use the `Dto` suffix for non-DTO classess (model, services, repositories, entities, use cases)

## Forbidden

- No HTTP client calls outside of service layer.
- No DB queries outside of repository layer.
- Controllers must call use case layer, never directly call repository or service layer.
- Use Case layer must call repository or service layer, never directly call DB or external API.

## When adding a feature

1. Add/extend the repository method for data access.
2. Add/extend the service method for external API access.
3. Wire the controller to the use case.
4. Wire the use case to the repository and/or service.
5. Add/extend the DTO class if needed.
6. Create DI bindings for new repository and/or service implementations in `lib/di` directory.
