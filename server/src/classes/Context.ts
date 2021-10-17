import { Response } from 'express';
import { EnhancedRequest } from '../@types/EnhancedRequest';

export interface Context {
  req: EnhancedRequest;
  res: Response;
}
