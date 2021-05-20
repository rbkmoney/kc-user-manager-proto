namespace java com.rbkmoney.user
namespace erlang user

struct User {
    required string email
    optional string realm
    optional string firstName
    optional string lastName
}

struct UserEmailActionsRequest {
    required string email
    required list<UserAction> actions
    optional string realm
    optional RedirectParams redirectParams;
}

enum UserAction {
    UPDATE_PASSWORD
    VERIFY_EMAIL
    UPDATE_PROFILE
}

struct RedirectParams {
    required string clientID
    required string redirectURI
}

struct Response {
    required Status status
    required string additionalInfo
}

enum Status {
    SUCCESS
    FAIL
    TECHNICAL_ERROR
}

exception UserServiceException {
    optional string reason
}

service UserService {

    Response Create (1: User user) throws (1: UserServiceException ex)

    Response SendUserEmailActions(1: UserEmailActionsRequest userActions) throws (1: UserServiceException ex)

}
