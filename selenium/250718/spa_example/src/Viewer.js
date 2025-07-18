import React, { useState } from "react";

const Viewer = ({ count }) => {
  return (
    <div>
      <div>
        현재 카운트 :<h1>{count}</h1>
      </div>
    </div>
  );
};

export default Viewer;
