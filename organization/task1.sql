with recursive
    subordinates as ( select e.EmployeeID, e.Name, e.ManagerID, e.DepartmentID, e.RoleID
                      from Employees e
                      where e.EmployeeID = 1

                      union all

                      select e.EmployeeID, e.Name, e.ManagerID, e.DepartmentID, e.RoleID
                      from Employees e
                               join subordinates s on e.ManagerID = s.EmployeeID ),
    employee_projects as ( select DepartmentID, string_agg(ProjectName, ', ' order by ProjectName) as ProjectNames
                           from Projects
                           group by DepartmentID ),
    employee_tasks as ( select AssignedTo, string_agg(TaskName, ', ' order by TaskName) as TaskNames
                        from Tasks
                        group by AssignedTo )
select s.EmployeeID,
       s.Name as EmployeeName,
       s.ManagerID,
       d.DepartmentName,
       r.RoleName,
       ep.ProjectNames,
       et.TaskNames
from subordinates s
         join Departments d on s.DepartmentID = d.DepartmentID
         join Roles r on s.RoleID = r.RoleID
         left join employee_projects ep on s.DepartmentID = ep.DepartmentID
         left join employee_tasks et on s.EmployeeID = et.AssignedTo
order by s.Name;
