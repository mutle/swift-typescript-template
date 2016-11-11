import * as React from "react";
import { Route, IndexRoute } from "react-router";

import AppContainerView from "./views/app-container";
import NotFoundView from "./views/not-found";

const routeMap = (
  <Route path="/" component={AppContainerView}>
    <IndexRoute component={NotFoundView} />
    <Route path="*" component={NotFoundView} />
  </Route>
);

export default routeMap;
