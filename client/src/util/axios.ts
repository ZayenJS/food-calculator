import axios from 'axios';
import { SERVER_ADDRESS } from '../constants';

export default axios.create({
  withCredentials: true,
  baseURL: SERVER_ADDRESS,
});
