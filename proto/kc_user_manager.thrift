namespace java com.rbkmoney.kc_user_manager
namespace erlang kc_user_manager

include "base.thrift"

struct UserID {
    1: required string email
    2: required string realm
}

struct User {
    1: required UserID user_id
    2: optional string first_name
    3: optional string last_name
}

struct EmailRequest {
    1: required UserID user_id
    2: optional RedirectParams redirect_params;
}

struct RedirectParams {
    1: required string client_id
    2: required string redirect_uri
}

struct CreateUserResponse {
    1: required Status status
}

struct SuccessfulUserCreation {
    1: required base.UUID id
}

struct FailedUserCreation {
    1: required string additionalInfo
}

union Status {
    1: SuccessfulUserCreation success
    2: FailedUserCreation fail
}

exception KeycloakUserManagerException {
    1: optional string reason
}

exception EmailSendException {}

/**
* Service which allows to:
*   -   create user in keycloak
*   -   verify user email
*   -   send magic link to user's email to set/update password
**/
service KeycloakUserManager {

    /**
    * Creates user in keycloak, username will be same as email
    **/
    CreateUserResponse Create (1: User user) throws (1: KeycloakUserManagerException ex)

    /**
    * Sends email to user with magic link to set/update password
    **/
    void SendUpdatePasswordEmail (1: EmailRequest email_request)
        throws (1: KeycloakUserManagerException ex1, 2: EmailSendException ex2)

    /**
    * Sends email to verify user's email address
    **/
    void SendVerifyUserEmail (1: EmailRequest email_request)
        throws (1: KeycloakUserManagerException ex1, 2: EmailSendException ex2)

}
