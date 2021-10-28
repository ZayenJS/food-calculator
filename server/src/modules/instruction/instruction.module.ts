import { Module } from '@nestjs/common';
import { InstructionResolver } from './instruction.resolver';
import { InstructionService } from './instruction.service';

@Module({
  providers: [InstructionResolver, InstructionService]
})
export class InstructionModule {}
