#!/bin/bash

ACTIONS_INIT='import { actionMaker } from "helpers/reduxHelpers";
import types from "./types";

export default {
  getAllUsersRequest: actionMaker(types.GET_ALL_USERS_REQUEST),
  getAllUsersSuccess: actionMaker(types.GET_ALL_USERS_SUCCESS),
  getAllUsersFailure: actionMaker(types.GET_ALL_USERS_FAILURE),
};
'

TYPES_INIT="const types = {
  GET_ALL_USERS_REQUEST: 'GET_ALL_USERS_REQUEST',
  GET_ALL_USERS_SUCCESS: 'GET_ALL_USERS_SUCCESS',
  GET_ALL_USERS_FAILURE: 'GET_ALL_USERS_FAILURE',
};

export default types;"

EFFECTS_INIT='import { showLoading, hideLoading } from "react-redux-loading-bar";
import { errObject } from "helpers/reduxHelpers";
import usersActions from "./actions";
import usersServices from "./services";

export default {
  getAllUsersRequest: () => async (dispatch) => {
    dispatch(showLoading());
    dispatch(usersActions.getAllUsersRequest());

    const response = await usersServices.getAllUsersService();
    const { data } = response;

    if (data) {
      dispatch(usersActions.getAllUsersSuccess(data));
      dispatch(hideLoading());
      return data;
    }

    dispatch(usersActions.getAllUsersFailure(errObject(response)));
    dispatch(hideLoading());
    return false;
  },
};'

REDUCERS_INIT='import types from "./types";

const initialState = {
  allUsers: {
    loading: false,
    data: null,
    error: false,
  },
};

const users = (state = initialState, action) => {
  switch (action.type) {
    // users requests
    case types.GET_ALL_USERS_REQUEST:
      return {
        ...state,
        allUsers: { loading: true, data: null, error: false },
      };
    case types.GET_ALL_USERS_SUCCESS:
      return {
        ...state,
        allUsers: { loading: false, data: action.payload, error: false },
      };
    case types.GET_ALL_USERS_FAILURE:
      return {
        ...state,
        allUsers: { loading: false, data: null, error: true },
      };
    default:
      return state;
  }
};

export default users;'

SELECTORS_INIT='import { createSelector } from "reselect";
/**
 * Main selectors, we did memoize this functions
 */
const getUsers = (state) => state.users;

export default {
  getAllUsersData: createSelector(getUsers, (users) => users.allUsers.data),
  getAllUsersLoading: createSelector(
    getUsers,
    (users) => users.allUsers.loading,
  ),
};'

SERVICES_INIT='import endpoints from "constants/endpoints";
import request from "store/request";

export default {
  getAllUsersService() {
    const url = endpoints.USERS.GET_ALL_USERS_SERVICE();
    return request.get(url);
  },
};'
