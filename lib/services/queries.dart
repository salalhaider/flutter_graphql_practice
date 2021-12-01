const getAllUsers = """ 
  query GetAllUsers {
    getAllUsers {
      id
      firstName
      lastName
      phoneNumber
      email
      profileImage
      notifToken
      cnic
      userType
      role
      createdAt
      updatedAt
    }
  }
""";

const addUser = """ 
  mutation Mutation(\$createUserInput: CreateUserInput!) {
    createUser(createUserInput: \$createUserInput) {
      id
      firstName
      lastName
      phoneNumber
      email
      cnic
      createdAt
      updatedAt
    }
  }
""";

const updateUser = """ 
  mutation UpdateUser(\$updateUserInput: UpdateUserInput!) {
  updateUser(updateUserInput: \$updateUserInput) {
      id
    }
  }
""";

const deleteUser = """ 
  mutation DeleteUser(\$userId: Int!) {
  deleteUser(userId: \$userId)
}
""";

const updatedUserStream = """ 
  subscription UserUpdated {
    userUpdated {
      id
      firstName
      lastName
      phoneNumber
      email
      profileImage
      notifToken
      cnic
      userType
      role
    }
  }
""";

// const getAllusers = """ 
// query Users{
//   users{
//     data {
//       id
//       email
//     }
//   }
// }
// """;
