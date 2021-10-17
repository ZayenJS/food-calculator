import { Request } from 'express';
import session from 'express-session';

// export interface EnhancedSession extends session.Session {
//   user?: User;
// }

export interface EnhancedRequest extends Request {
  body: {
    [key: string]: any;
  };
  // session: EnhancedSession;
}
