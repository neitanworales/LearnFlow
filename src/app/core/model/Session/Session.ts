import { UserRole } from "../UserRol";

export class Session {
    status?: string;
    token?: string;
    user_id?: number;
    expires_at?: Date;
    roles: UserRole[] = [];
}