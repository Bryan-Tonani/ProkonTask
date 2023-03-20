unit ComponentRegistration;

interface

procedure register;

implementation

uses
  Classes,
  PRStringGrid,
  DesignEditors,
  DesignIntf,
  CustomCellClasses;

procedure Register;
begin
  RegisterComponents('ProkonVCLControls', [TPRStringGrid]);
  RegisterPropertyEditor(TypeInfo(TPRCells), TPRStringGrid, '', TPRCellsPropertyEditor);
end;

end.
