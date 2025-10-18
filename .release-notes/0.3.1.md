## Changes Default value for new SQLTypes to SQLNull

Previously it was possible to create objects that were invalid if passed to the API as they'd allow NULL buffers with numeric lengths.  This should now prevent this.

