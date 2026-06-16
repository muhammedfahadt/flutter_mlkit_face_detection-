import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import { IViolation, NewViolation } from '../violation.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IViolation for edit and NewViolationFormGroupInput for create.
 */
type ViolationFormGroupInput = IViolation | PartialWithRequiredKeyOf<NewViolation>;

type ViolationFormDefaults = Pick<NewViolation, 'id'>;

type ViolationFormGroupContent = {
  id: FormControl<IViolation['id'] | NewViolation['id']>;
  violationType: FormControl<IViolation['violationType']>;
  points: FormControl<IViolation['points']>;
  appUser: FormControl<IViolation['appUser']>;
  content: FormControl<IViolation['content']>;
};

export type ViolationFormGroup = FormGroup<ViolationFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class ViolationFormService {
  createViolationFormGroup(violation: ViolationFormGroupInput = { id: null }): ViolationFormGroup {
    const violationRawValue = {
      ...this.getFormDefaults(),
      ...violation,
    };
    return new FormGroup<ViolationFormGroupContent>({
      id: new FormControl(
        { value: violationRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      violationType: new FormControl(violationRawValue.violationType),
      points: new FormControl(violationRawValue.points),
      appUser: new FormControl(violationRawValue.appUser),
      content: new FormControl(violationRawValue.content),
    });
  }

  getViolation(form: ViolationFormGroup): IViolation | NewViolation {
    return form.getRawValue() as IViolation | NewViolation;
  }

  resetForm(form: ViolationFormGroup, violation: ViolationFormGroupInput): void {
    const violationRawValue = { ...this.getFormDefaults(), ...violation };
    form.reset(
      {
        ...violationRawValue,
        id: { value: violationRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): ViolationFormDefaults {
    return {
      id: null,
    };
  }
}
